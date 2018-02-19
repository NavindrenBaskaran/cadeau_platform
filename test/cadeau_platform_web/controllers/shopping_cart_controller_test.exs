defmodule CadeauPlatformWeb.ShoppingCartControllerTest do
  use CadeauPlatformWeb.ConnCase

  alias CadeauPlatform.Shopping
  alias CadeauPlatform.Repo

  use Plug.Test

  describe "index" do
    test "lists all items in users shopping cart which has status :in_cart", %{conn: conn} do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      product2 = insert(:product)
      cart_product = insert(:cart_product, cart: cart, product: product)
      cart_product2 = insert(:cart_product, cart: cart, product: product2, status: :checked_out)

      response = conn
                 |> init_test_session(current_user_id: user.id)
                 |> get(shopping_cart_path(conn, :index))

      assert Enum.count(response.assigns.product_lines) == 1
      assert Enum.map(response.assigns.product_lines, fn(product_line) -> product_line.product.id end) == [product.id]
    end
  end

  describe "add" do
    test "add item to shopping cart", %{conn: conn}  do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      product2 = insert(:product)

      response = conn
                 |> init_test_session(current_user_id: user.id)
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(shopping_cart_path(conn, :add, %{product_id: product.id, _csrf_token: "123"}))
      cart  = Shopping.get_cart_by_user_id(user.id)
              |> Repo.preload(:products)

      assert Poison.Parser.parse!(~s(#{response.resp_body})) == "{\"status\":200}"
      assert Enum.count(cart.products) == 1
    end

    test "add item to shopping cart, item already exist in cart and it increases the quantity" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      product2 = insert(:product)

      conn
      |> init_test_session(current_user_id: user.id)
      |> put_private(:plug_skip_csrf_protection, true)
      |> post(shopping_cart_path(conn, :add, %{product_id: product.id, _csrf_token: "123"}))

      response = conn
                 |> init_test_session(current_user_id: user.id)
                 |> put_private(:plug_skip_csrf_protection, true)
                 |> post(shopping_cart_path(conn, :add, %{product_id: product.id, _csrf_token: "123"}))

      cart  = Shopping.get_cart_by_user_id(user.id) |> Repo.preload(:products)
      product_lines = Shopping.get_products_in_cart(user.id, cart.id)

      assert Poison.Parser.parse!(~s(#{response.resp_body})) == "{\"status\":200}"
      assert Enum.count(cart.products) == 1
      assert Enum.count(product_lines) == 1
      assert Enum.map(product_lines, fn(product_line) -> product_line.product_id end) == [product.id]
      assert Enum.map(product_lines, fn(product_line) -> product_line.quantity end) == [2]
    end
  end
end

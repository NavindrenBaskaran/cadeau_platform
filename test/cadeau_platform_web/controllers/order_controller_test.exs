defmodule CadeauPlatformWeb.OrderControllerTest do
  use CadeauPlatformWeb.ConnCase

  import Ecto.Query, warn: false
  alias CadeauPlatform.Shopping
  alias CadeauPlatform.Shopping.Cart
  alias CadeauPlatform.Checkout.Order
  alias CadeauPlatform.Repo

  use Plug.Test

  describe "create_order" do
    test "places an order with the items in the users cart with status :in_cart", %{conn: conn} do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      product2 = insert(:product)
      cart_product = insert(:cart_product, cart: cart, product: product)
      cart_product2 = insert(:cart_product, cart: cart, product: product2, status: :checked_out)

      response = conn
                 |> init_test_session(current_user_id: user.id)
                 |> post(order_path(conn, :create_order))

      order = from(o in Order, order_by: [desc: o.id], limit: 1)
              |> Repo.one
              |> Repo.preload([product_lines: :product, receipt: :receipt_detail])

      cart = Shopping.get_cart_by_user_id(user.id)
      products = Shopping.get_products_in_cart(cart.id)

      assert get_flash(response, :info) == "Order Placed"
      assert Enum.count(products) == 0
      assert Enum.count(order.product_lines) == 1
      assert order.receipt.order_id == order.id
      assert Enum.count(order.receipt.receipt_detail.purchase_data) == 1
      assert Enum.map(order.product_lines, fn(product_line) -> product_line.status end) == [:checked_out]
      assert Enum.map(order.product_lines, fn(product_line) -> product_line.quantity end) == [1]
      assert Enum.map(order.product_lines, fn(product_line) -> product_line.product.id end) == [product.id]
    end
  end

  describe "index" do
    test "returns all order placed by the current user", %{conn: conn} do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      product2 = insert(:product)
      cart_product = insert(:cart_product, cart: cart, product: product)
      cart_product2 = insert(:cart_product, cart: cart, product: product2, status: :checked_out)

      conn = conn
             |> init_test_session(current_user_id: user.id)
             |> post(order_path(conn, :create_order))

     response = conn
                |> get(order_path(conn, :index))

      assert Enum.count(response.assigns.orders) == 1
    end

    test "returns an empty list, as no orders were placed by the current user", %{conn: conn} do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      product2 = insert(:product)
      cart_product = insert(:cart_product, cart: cart, product: product)
      cart_product2 = insert(:cart_product, cart: cart, product: product2, status: :checked_out)

     response = conn
                |> get(order_path(conn, :index))

      assert Enum.count(response.assigns.orders) == 0
      assert response.assigns.orders == []
    end
  end

  describe "show" do
    test "valid order, populates the conn with the order details", %{conn: conn} do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      product2 = insert(:product)
      cart_product = insert(:cart_product, cart: cart, product: product)
      cart_product2 = insert(:cart_product, cart: cart, product: product2, status: :checked_out)

       conn
       |> init_test_session(current_user_id: user.id)
       |> post(order_path(conn, :create_order))

      order = from(o in Order, order_by: [desc: o.id], limit: 1)
              |> Repo.one
              |> Repo.preload([product_lines: :product, receipt: :receipt_detail])

      response = conn
                 |> init_test_session(current_user_id: user.id)
                 |> get(order_path(conn, :show, order.id))

      assert response.assigns.purchase_data == order.receipt.receipt_detail.purchase_data
      assert response.assigns.total_amount == order.receipt.total_amount
      assert response.assigns.total_sales_tax == order.receipt.total_sales_tax
    end

    test "invalid order, show appropriate error message", %{conn: conn} do
      user = insert(:user)

      response = conn
                 |> init_test_session(current_user_id: user.id)
                 |> get(order_path(conn, :show, 100))

      assert get_flash(response, :error) == "Uh-oh, apparently this order does not exist."
    end
  end
end

defmodule CadeauPlatform.ShoppingTest do
  use CadeauPlatform.DataCase

  alias CadeauPlatform.Shopping

  describe "carts" do
    alias CadeauPlatform.Shopping.Order

    test "create_cart/1, creates cart for the user" do
      user = insert(:user)
      assert {:ok, cart} = Shopping.create_cart(%{user_id: user.id})
    end

    test "get_cart_by_user_id/1, returns the cart beloging to the user" do
      user = insert(:user)
      user1 = insert(:user, name: "Alex" , email: "alex@gmail.com")
      {:ok, cart} = Shopping.create_cart(%{user_id: user.id})
      {:ok, cart1} = Shopping.create_cart(%{user_id: user1.id})

      assert cart.id == Shopping.get_cart_by_user_id(user.id).id
      assert cart1.id != Shopping.get_cart_by_user_id(user.id).id
    end

    test "get_products_in_cart/2, returns all products in the cart with status :in_cart" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      product2 = insert(:product)
      cart_product = insert(:cart_product, cart: cart, product: product)
      cart_product2 = insert(:cart_product, cart: cart, product: product2, status: :checked_out)

      assert Enum.count(Shopping.get_products_in_cart(user.id, cart.id)) == 1
      assert Enum.map(Shopping.get_products_in_cart(user.id, cart.id), fn(product_line) -> product_line.product.id end) == [product.id]
    end

    test "add_product_to_cart/2, add product to user's cart" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      attrs = %{cart_id: cart.id, product_id: product.id}
      Shopping.add_product_to_cart(attrs)

      cart = cart |> Repo.preload(:products)

      assert Enum.count(cart.products) == 1
      assert Enum.map(Shopping.get_products_in_cart(user.id, cart.id), fn(product_line) -> product_line.status end) == [:in_cart]
    end

    test "add_product_to_cart/2, if item already in cart it updates quantity" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      attrs = %{cart_id: cart.id, product_id: product.id}
      Shopping.add_product_to_cart(attrs)
      Shopping.add_product_to_cart(attrs)

      cart = cart |> Repo.preload(:products)

      assert Enum.count(cart.products) == 1
      assert Enum.map(Shopping.get_products_in_cart(user.id, cart.id), fn(product_line) -> product_line.quantity end) == [2]
      assert Enum.map(Shopping.get_products_in_cart(user.id, cart.id), fn(product_line) -> product_line.status end) == [:in_cart]
    end

    test "add_product_to_cart/2, if item already exists in cart with :checked_out status it adds a new record" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      cart_product = insert(:cart_product, cart: cart, product: product, status: :checked_out)
      attrs = %{cart_id: cart.id, product_id: product.id}

      Shopping.add_product_to_cart(attrs)

      assert Enum.map(Shopping.get_products_in_cart(user.id, cart.id), fn(product_line) -> product_line.quantity end) == [1]
      assert Enum.map(Shopping.get_products_in_cart(user.id, cart.id), fn(product_line) -> product_line.status end) == [:in_cart]
    end
  end
end

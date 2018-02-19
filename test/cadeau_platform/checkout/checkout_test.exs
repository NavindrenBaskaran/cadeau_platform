defmodule CadeauPlatform.CheckoutTest do
  use CadeauPlatform.DataCase

  alias CadeauPlatform.Checkout

  describe "orders" do
    alias CadeauPlatform.Checkout.Order

    test "get_orders/1, returns order beloging to the user" do
      user = insert(:user)
      user2 = insert(:user, email: "test@gmail.com", name: "test")

      order1 = insert(:order, user: user)
      order2 = insert(:order, user: user)
      order3 = insert(:order, user: user2)


      assert 2 == Enum.count(Checkout.get_orders(user.id))
      assert 1 == Enum.count(Checkout.get_orders(user2.id))
    end

    test "get_order/2, returns order beloging to the user" do
      user = insert(:user)
      user2 = insert(:user, email: "test@gmail.com", name: "test")

      order1 = insert(:order, user: user)

      assert order1.id == Checkout.get_order(user.id, order1.id).id
    end

    test "process_order/2, creates order, checkouts item from cart, creates receipt and receipt detail" do
      user = insert(:user)
      cart = insert(:cart, user: user)
      product = insert(:product)
      cart_product = insert(:cart_product, cart: cart, product: product)

      { _, order } = Checkout.process_order(user.id, cart.id)
      order = order |> Repo.preload([product_lines: :product, receipt: :receipt_detail])

      assert Enum.map(order.product_lines, fn(product_line) -> product_line.product.id end) == [product.id]
      assert Enum.map(order.product_lines, fn(product_line) -> product_line.status end) == [:checked_out]
      assert order.receipt.order_id == order.id
      assert Enum.count(order.receipt.receipt_detail.purchase_data) == 1
    end
  end
end

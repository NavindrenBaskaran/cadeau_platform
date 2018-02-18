defmodule CadeauPlatform.Checkout do
  @moduledoc """
  The Checkout context.
  """

  import Ecto.Query, warn: false
  alias CadeauPlatform.Repo

  alias CadeauPlatform.Checkout.{Order, Receipt, ReceiptDetail}
  alias CadeauPlatform.Inventory.Product
  alias CadeauPlatform.Shopping.{Cart, CartProduct}
  alias CadeauPlatform.CheckoutCalculator.Calculator

  def get_orders(user_id) do
    from(o in Order, where: o.user_id == ^user_id)
    |> Repo.all
  end

  def get_order(user_id, id) do
    Order
    |> Repo.get_by(id: id, user_id: user_id)
    |> Repo.preload(receipt: :receipt_detail)
  end

  def process_order(user_id, cart_id) do
    case create_order(%{user_id: user_id}) do
      {:ok, order} ->
        Repo.transaction(fn ->
          checkout_products_in_cart(cart_id, order.id)
          order = Repo.preload(order, product_lines: [product: :taxes])
          order
          |> create_receipt
          |> create_receipt_detail(order.product_lines)
          order
        end)
      {:error, _} ->
        nil
    end
  end

  defp create_order(attrs) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  defp create_receipt(order) do
    {total_amount, total_sales_tax} = receipt_params(order.product_lines)
    %Receipt{}
    |> Receipt.changeset(%{total_amount: total_amount, total_sales_tax:  total_sales_tax, order_id: order.id})
    |> Repo.insert()
  end

  defp create_receipt_detail({_, receipt}, product_lines) do
    purchase_data = receipt_detail(product_lines)
    %ReceiptDetail{}
    |> ReceiptDetail.changeset(%{receipt_id: receipt.id, purchase_data: purchase_data})
    |> Repo.insert()
  end

  defp receipt_params(product_lines) do
    {total_payable_amount(product_lines), total_sales_tax(product_lines)}
  end

  defp checkout_products_in_cart(cart_id, order_id) do
    from(cp in CartProduct, where: cp.cart_id == ^cart_id and cp.status == ^:in_cart)
    |> Repo.update_all(set: [order_id: order_id, status: :checked_out])
  end

  defp total_payable_amount(product_lines) do
    Calculator.total_order_amount(product_lines)
  end

  defp total_sales_tax(product_lines) do
    Calculator.total_sales_tax_amount(product_lines)
  end

  defp receipt_detail(product_lines) do
    Calculator.payable_per_product(product_lines)
  end
end

defmodule CadeauPlatformWeb.OrderController do
  use CadeauPlatformWeb, :controller

  alias CadeauPlatform.Checkout
  alias CadeauPlatform.Checkout.Order

  def index(conn, _params) do
    orders = case conn.assigns.authenticated do
              false ->
                []
              true ->
                Checkout.get_orders(conn.assigns.user_id)
             end
    conn
    |> assign(:orders, orders)
    |> render("index.html", conn.assigns)
  end

  def create_order(conn, _params) do
    case Checkout.process_order(conn.assigns.user_id, conn.assigns.cart_id) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order Placed")
        |> redirect(to: order_path(conn, :show, order))
      _ ->
        conn
        |> put_flash(:error, "Checkout Failed")
        |> redirect(to: shopping_cart_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    case Checkout.get_order(conn.assigns.user_id, id) do
      nil ->
        conn
        |> put_flash(:error, "Uh-oh, apparently this order does not exist.")
        |> redirect(to: order_path(conn, :index))
      order ->
        conn
        |> assign(:purchase_data, order.receipt.receipt_detail.purchase_data)
        |> assign(:total_amount, order.receipt.total_amount)
        |> assign(:total_sales_tax, order.receipt.total_sales_tax)
        |> render("show.html", conn.assigns)
    end
  end
end

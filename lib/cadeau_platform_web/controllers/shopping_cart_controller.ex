defmodule CadeauPlatformWeb.ShoppingCartController do
  use CadeauPlatformWeb, :controller

  alias Plug.Conn
  alias CadeauPlatform.Shopping
  import CadeauPlatform.Helpers.HelperFunctions

  def index(conn, _params) do
    product_lines = Shopping.get_products_in_cart(conn.assigns.cart)
    conn
    |> assign(:product_lines, product_lines)
    |> render("index.html", conn.assigns)
  end

  def add(conn, params) do
    sanitized_params = string_to_atom(params)
    whitelisted_params = Map.take(sanitized_params, [:product_id])
    attrs = Map.put(whitelisted_params, :cart_id, conn.assigns.cart )

    case Shopping.add_product_to_cart(attrs) do
      {:ok, _} ->
        json conn, Poison.encode!(%{"status": 200})
      {:error, _} ->
        json conn, Poison.encode!(%{"status": 400})
    end
  end
end

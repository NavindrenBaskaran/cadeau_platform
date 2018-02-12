defmodule CadeauPlatformWeb.ShoppingCartController do
  use CadeauPlatformWeb, :controller


  alias CadeauPlatform.Inventory

  def index(conn, _params) do
    selected_product_ids = get_selected_items(Map.get(conn.cookies, "items"))
    products = case selected_product_ids do
                  [] ->
                     []
                  _ ->
                    Inventory.get_selected_products(selected_product_ids)
                end
    conn
    |> assign(:selected_products, products)
    |> render("index.html", conn.assigns)
  end

  defp get_selected_items(items) do
    case items do
      nil ->
        []
      _ ->
        String.split(items, ":")
    end
  end
end

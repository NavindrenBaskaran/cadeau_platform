defmodule CadeauPlatformWeb.ShoppingCartController do
  use CadeauPlatformWeb, :controller

  alias CadeauPlatform.Shopping

  def index(conn, _params) do
    product_lines = case Kernel.is_nil(conn.assigns.cart_id) do
                      true ->
                          []
                      false ->
                        Shopping.get_products_in_cart(conn.assigns.user_id, conn.assigns.cart_id)
                    end
    conn
    |> assign(:product_lines, product_lines)
    |> render("index.html", conn.assigns)
  end

  def add(conn, %{"_csrf_token" => _ , "product_id" => product_id}) do
    with true <- conn.assigns.authenticated,
         false <- Kernel.is_nil(conn.assigns.cart_id),
         {:ok, _} <- Shopping.add_product_to_cart(%{cart_id: conn.assigns.cart_id, product_id: product_id})
    do
      json conn, Poison.encode!(%{"status": 200})
    else
      {:error, _} ->
        json conn, Poison.encode!(%{"status": 500})
      _ ->
        json conn, Poison.encode!(%{"status": 400})
    end
  end
end

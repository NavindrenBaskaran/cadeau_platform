defmodule CadeauPlatformWeb.OrderController do
  use CadeauPlatformWeb, :controller

  alias CadeauPlatform.Shopping
  alias CadeauPlatform.Shopping.Order

  def index(conn, _params) do
    conn
    |> render("index.html", conn.assigns)

  end
end

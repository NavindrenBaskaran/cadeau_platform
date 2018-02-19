defmodule CadeauPlatformWeb.PageController do
  use CadeauPlatformWeb, :controller

  alias CadeauPlatform.Inventory
  
  def index(conn, _params) do
    items = Inventory.list_products
    conn
      |>assign(:items, items)
      |>render("index.html", conn.assigns)
  end
end

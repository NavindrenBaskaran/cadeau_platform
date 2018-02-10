defmodule CadeauPlatformWeb.PageController do
  use CadeauPlatformWeb, :controller

  # alias CadeauPlatform.Items
  # alias CadeauPlatform.Items.Page

  def index(conn, _params) do
    render(conn, "index.html", conn.assigns)
  end
end

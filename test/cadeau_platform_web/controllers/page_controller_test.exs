defmodule CadeauPlatformWeb.PageControllerTest do
  use CadeauPlatformWeb.ConnCase

  alias CadeauPlatform.Items

  describe "index" do
    test "lists all pages", %{conn: conn} do
      conn = get conn, page_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Pages"
    end
  end
end

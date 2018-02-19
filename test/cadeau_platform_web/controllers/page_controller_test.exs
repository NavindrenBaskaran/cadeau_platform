defmodule CadeauPlatformWeb.PageControllerTest do
  use CadeauPlatformWeb.ConnCase

  alias CadeauPlatform.Inventory

  describe "index" do
    test "lists all items in inventory", %{conn: conn} do
      product1 = insert(:product, name: "book", price: Money.new(12.49, :MYR))
      product2 = insert(:product, name: "music cd", price: Money.new(14.99, :MYR))

      response = conn |> get(page_path(conn, :index))
      assert Enum.count(response.assigns.items) == 2
    end
  end
end

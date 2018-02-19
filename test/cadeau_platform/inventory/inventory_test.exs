defmodule CadeauPlatform.InventoryTest do
  use CadeauPlatform.DataCase

  alias CadeauPlatform.Inventory

  describe "products" do
    alias CadeauPlatform.Inventory.Product

    test "list_products/0 returns all products" do
      insert(:product, name: "book", price: Money.new(12.49, :MYR))
      insert(:product, name: "music cd", price: Money.new(14.99, :MYR))
      insert(:product, name: "chocolate bar", price: Money.new(0.85, :MYR))

      assert Enum.count(Inventory.list_products()) == 3
    end
  end
end

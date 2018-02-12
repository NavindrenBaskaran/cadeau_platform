defmodule CadeauPlatform.InventoryTest do
  use CadeauPlatform.DataCase

  alias CadeauPlatform.Inventory

  describe "products" do
    alias CadeauPlatform.Inventory.Product

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Inventory.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Inventory.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Inventory.create_product(@valid_attrs)
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = Inventory.update_product(product, @update_attrs)
      assert %Product{} = product
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_product(product, @invalid_attrs)
      assert product == Inventory.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Inventory.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Inventory.change_product(product)
    end
  end

  describe "categories" do
    alias CadeauPlatform.Inventory.Category

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Inventory.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Inventory.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Inventory.create_category(@valid_attrs)
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, category} = Inventory.update_category(category, @update_attrs)
      assert %Category{} = category
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_category(category, @invalid_attrs)
      assert category == Inventory.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Inventory.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Inventory.change_category(category)
    end
  end

  describe "taxes" do
    alias CadeauPlatform.Inventory.Tax

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def tax_fixture(attrs \\ %{}) do
      {:ok, tax} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_tax()

      tax
    end

    test "list_taxes/0 returns all taxes" do
      tax = tax_fixture()
      assert Inventory.list_taxes() == [tax]
    end

    test "get_tax!/1 returns the tax with given id" do
      tax = tax_fixture()
      assert Inventory.get_tax!(tax.id) == tax
    end

    test "create_tax/1 with valid data creates a tax" do
      assert {:ok, %Tax{} = tax} = Inventory.create_tax(@valid_attrs)
    end

    test "create_tax/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_tax(@invalid_attrs)
    end

    test "update_tax/2 with valid data updates the tax" do
      tax = tax_fixture()
      assert {:ok, tax} = Inventory.update_tax(tax, @update_attrs)
      assert %Tax{} = tax
    end

    test "update_tax/2 with invalid data returns error changeset" do
      tax = tax_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_tax(tax, @invalid_attrs)
      assert tax == Inventory.get_tax!(tax.id)
    end

    test "delete_tax/1 deletes the tax" do
      tax = tax_fixture()
      assert {:ok, %Tax{}} = Inventory.delete_tax(tax)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_tax!(tax.id) end
    end

    test "change_tax/1 returns a tax changeset" do
      tax = tax_fixture()
      assert %Ecto.Changeset{} = Inventory.change_tax(tax)
    end
  end

  describe "products_taxes" do
    alias CadeauPlatform.Inventory.ProductTax

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def product_tax_fixture(attrs \\ %{}) do
      {:ok, product_tax} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_product_tax()

      product_tax
    end

    test "list_products_taxes/0 returns all products_taxes" do
      product_tax = product_tax_fixture()
      assert Inventory.list_products_taxes() == [product_tax]
    end

    test "get_product_tax!/1 returns the product_tax with given id" do
      product_tax = product_tax_fixture()
      assert Inventory.get_product_tax!(product_tax.id) == product_tax
    end

    test "create_product_tax/1 with valid data creates a product_tax" do
      assert {:ok, %ProductTax{} = product_tax} = Inventory.create_product_tax(@valid_attrs)
    end

    test "create_product_tax/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_product_tax(@invalid_attrs)
    end

    test "update_product_tax/2 with valid data updates the product_tax" do
      product_tax = product_tax_fixture()
      assert {:ok, product_tax} = Inventory.update_product_tax(product_tax, @update_attrs)
      assert %ProductTax{} = product_tax
    end

    test "update_product_tax/2 with invalid data returns error changeset" do
      product_tax = product_tax_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_product_tax(product_tax, @invalid_attrs)
      assert product_tax == Inventory.get_product_tax!(product_tax.id)
    end

    test "delete_product_tax/1 deletes the product_tax" do
      product_tax = product_tax_fixture()
      assert {:ok, %ProductTax{}} = Inventory.delete_product_tax(product_tax)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_product_tax!(product_tax.id) end
    end

    test "change_product_tax/1 returns a product_tax changeset" do
      product_tax = product_tax_fixture()
      assert %Ecto.Changeset{} = Inventory.change_product_tax(product_tax)
    end
  end
end

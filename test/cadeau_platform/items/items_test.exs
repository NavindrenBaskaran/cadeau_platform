defmodule CadeauPlatform.ItemsTest do
  use CadeauPlatform.DataCase

  alias CadeauPlatform.Items

  describe "pages" do
    alias CadeauPlatform.Items.Page

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Items.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Items.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Items.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Items.create_page(@valid_attrs)
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, page} = Items.update_page(page, @update_attrs)
      assert %Page{} = page
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_page(page, @invalid_attrs)
      assert page == Items.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Items.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Items.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Items.change_page(page)
    end
  end
end

defmodule CadeauPlatform.ShoppingTest do
  use CadeauPlatform.DataCase

  alias CadeauPlatform.Shopping

  describe "orders" do
    alias CadeauPlatform.Shopping.Order

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shopping.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Shopping.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Shopping.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Shopping.create_order(@valid_attrs)
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, order} = Shopping.update_order(order, @update_attrs)
      assert %Order{} = order
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Shopping.update_order(order, @invalid_attrs)
      assert order == Shopping.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Shopping.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Shopping.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Shopping.change_order(order)
    end
  end

  describe "order_lines" do
    alias CadeauPlatform.Shopping.OrderLine

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def order_line_fixture(attrs \\ %{}) do
      {:ok, order_line} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shopping.create_order_line()

      order_line
    end

    test "list_order_lines/0 returns all order_lines" do
      order_line = order_line_fixture()
      assert Shopping.list_order_lines() == [order_line]
    end

    test "get_order_line!/1 returns the order_line with given id" do
      order_line = order_line_fixture()
      assert Shopping.get_order_line!(order_line.id) == order_line
    end

    test "create_order_line/1 with valid data creates a order_line" do
      assert {:ok, %OrderLine{} = order_line} = Shopping.create_order_line(@valid_attrs)
    end

    test "create_order_line/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_order_line(@invalid_attrs)
    end

    test "update_order_line/2 with valid data updates the order_line" do
      order_line = order_line_fixture()
      assert {:ok, order_line} = Shopping.update_order_line(order_line, @update_attrs)
      assert %OrderLine{} = order_line
    end

    test "update_order_line/2 with invalid data returns error changeset" do
      order_line = order_line_fixture()
      assert {:error, %Ecto.Changeset{}} = Shopping.update_order_line(order_line, @invalid_attrs)
      assert order_line == Shopping.get_order_line!(order_line.id)
    end

    test "delete_order_line/1 deletes the order_line" do
      order_line = order_line_fixture()
      assert {:ok, %OrderLine{}} = Shopping.delete_order_line(order_line)
      assert_raise Ecto.NoResultsError, fn -> Shopping.get_order_line!(order_line.id) end
    end

    test "change_order_line/1 returns a order_line changeset" do
      order_line = order_line_fixture()
      assert %Ecto.Changeset{} = Shopping.change_order_line(order_line)
    end
  end

  describe "receipts" do
    alias CadeauPlatform.Shopping.Receipt

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def receipt_fixture(attrs \\ %{}) do
      {:ok, receipt} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shopping.create_receipt()

      receipt
    end

    test "list_receipts/0 returns all receipts" do
      receipt = receipt_fixture()
      assert Shopping.list_receipts() == [receipt]
    end

    test "get_receipt!/1 returns the receipt with given id" do
      receipt = receipt_fixture()
      assert Shopping.get_receipt!(receipt.id) == receipt
    end

    test "create_receipt/1 with valid data creates a receipt" do
      assert {:ok, %Receipt{} = receipt} = Shopping.create_receipt(@valid_attrs)
    end

    test "create_receipt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_receipt(@invalid_attrs)
    end

    test "update_receipt/2 with valid data updates the receipt" do
      receipt = receipt_fixture()
      assert {:ok, receipt} = Shopping.update_receipt(receipt, @update_attrs)
      assert %Receipt{} = receipt
    end

    test "update_receipt/2 with invalid data returns error changeset" do
      receipt = receipt_fixture()
      assert {:error, %Ecto.Changeset{}} = Shopping.update_receipt(receipt, @invalid_attrs)
      assert receipt == Shopping.get_receipt!(receipt.id)
    end

    test "delete_receipt/1 deletes the receipt" do
      receipt = receipt_fixture()
      assert {:ok, %Receipt{}} = Shopping.delete_receipt(receipt)
      assert_raise Ecto.NoResultsError, fn -> Shopping.get_receipt!(receipt.id) end
    end

    test "change_receipt/1 returns a receipt changeset" do
      receipt = receipt_fixture()
      assert %Ecto.Changeset{} = Shopping.change_receipt(receipt)
    end
  end
end

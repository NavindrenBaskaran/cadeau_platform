defmodule CadeauPlatform.CheckoutTest do
  use CadeauPlatform.DataCase

  alias CadeauPlatform.Checkout

  describe "orders" do
    alias CadeauPlatform.Checkout.Order

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Checkout.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Checkout.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Checkout.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Checkout.create_order(@valid_attrs)
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Checkout.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, order} = Checkout.update_order(order, @update_attrs)
      assert %Order{} = order
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Checkout.update_order(order, @invalid_attrs)
      assert order == Checkout.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Checkout.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Checkout.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Checkout.change_order(order)
    end
  end

  describe "receipt_details" do
    alias CadeauPlatform.Checkout.ReceiptDetail

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def receipt_detail_fixture(attrs \\ %{}) do
      {:ok, receipt_detail} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Checkout.create_receipt_detail()

      receipt_detail
    end

    test "list_receipt_details/0 returns all receipt_details" do
      receipt_detail = receipt_detail_fixture()
      assert Checkout.list_receipt_details() == [receipt_detail]
    end

    test "get_receipt_detail!/1 returns the receipt_detail with given id" do
      receipt_detail = receipt_detail_fixture()
      assert Checkout.get_receipt_detail!(receipt_detail.id) == receipt_detail
    end

    test "create_receipt_detail/1 with valid data creates a receipt_detail" do
      assert {:ok, %ReceiptDetail{} = receipt_detail} = Checkout.create_receipt_detail(@valid_attrs)
    end

    test "create_receipt_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Checkout.create_receipt_detail(@invalid_attrs)
    end

    test "update_receipt_detail/2 with valid data updates the receipt_detail" do
      receipt_detail = receipt_detail_fixture()
      assert {:ok, receipt_detail} = Checkout.update_receipt_detail(receipt_detail, @update_attrs)
      assert %ReceiptDetail{} = receipt_detail
    end

    test "update_receipt_detail/2 with invalid data returns error changeset" do
      receipt_detail = receipt_detail_fixture()
      assert {:error, %Ecto.Changeset{}} = Checkout.update_receipt_detail(receipt_detail, @invalid_attrs)
      assert receipt_detail == Checkout.get_receipt_detail!(receipt_detail.id)
    end

    test "delete_receipt_detail/1 deletes the receipt_detail" do
      receipt_detail = receipt_detail_fixture()
      assert {:ok, %ReceiptDetail{}} = Checkout.delete_receipt_detail(receipt_detail)
      assert_raise Ecto.NoResultsError, fn -> Checkout.get_receipt_detail!(receipt_detail.id) end
    end

    test "change_receipt_detail/1 returns a receipt_detail changeset" do
      receipt_detail = receipt_detail_fixture()
      assert %Ecto.Changeset{} = Checkout.change_receipt_detail(receipt_detail)
    end
  end
end

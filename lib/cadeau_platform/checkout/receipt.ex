defmodule CadeauPlatform.Checkout.Receipt do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Checkout.{Receipt, Order, ReceiptDetail}

  schema "receipts" do
    belongs_to :order, Order
    has_one :receipt_detail, ReceiptDetail
    field :total_amount, Money.Ecto.Composite.Type
    field :total_sales_tax, Money.Ecto.Composite.Type
    timestamps()
  end

  @doc false
  def changeset(%Receipt{} = receipt, attrs) do
    receipt
    |> cast(attrs, [:order_id, :total_amount, :total_sales_tax])
    |> validate_required([:order_id, :total_amount, :total_sales_tax])
  end
end

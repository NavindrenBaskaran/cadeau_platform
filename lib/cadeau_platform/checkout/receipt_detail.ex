defmodule CadeauPlatform.Checkout.ReceiptDetail do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Checkout.ReceiptDetail


  schema "receipt_details" do
    belongs_to :receipt, Receipt
    field :purchase_data, {:array, :map}

    timestamps()
  end

  @doc false
  def changeset(%ReceiptDetail{} = receipt_detail, attrs) do
    receipt_detail
    |> cast(attrs, [:receipt_id, :purchase_data])
    |> validate_required([:receipt_id, :purchase_data])
  end
end

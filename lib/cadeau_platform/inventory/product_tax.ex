defmodule CadeauPlatform.Inventory.ProductTax do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Inventory.{ProductTax, Product, Tax}

  @primary_key false
  schema "products_taxes" do
    belongs_to :product, Product
    belongs_to :tax, Tax
    timestamps()
  end

  @doc false
  def changeset(%ProductTax{} = product_tax, attrs) do
    product_tax
    |> cast(attrs, [:product_id, :tax_id])
    |> validate_required([:product_id, :tax_id])
  end
end

defmodule CadeauPlatform.Inventory.Tax do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Inventory.{Tax, Product, ProductTax}

  schema "taxes" do
    field :name, :string
    field :tax_rate, :decimal, default: 0.0
    many_to_many :products, Product, join_through: ProductTax
    timestamps()
  end

  @doc false
  def changeset(%Tax{} = tax, attrs) do
    tax
    |> cast(attrs, [])
    |> validate_required([])
  end
end

defmodule CadeauPlatform.Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Inventory.Product


  schema "products" do
    field :name, :string
    field :price_cents, Money.Ecto.Type
    field :description, :text
    field :imported, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [])
    |> validate_required([])
  end
end

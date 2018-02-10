defmodule CadeauPlatform.Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Inventory.Product


  schema "products" do

    timestamps()
  end

  @doc false
  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [])
    |> validate_required([])
  end
end

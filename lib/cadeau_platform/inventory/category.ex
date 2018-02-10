defmodule CadeauPlatform.Inventory.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Inventory.Category


  schema "categories" do
    field :name, :string
    field :type, :integer
    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [])
    |> validate_required([])
  end
end
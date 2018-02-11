import EctoEnum
defenum CategoryTypeEnum, book: 0, health: 1, edible: 2, wear: 3

defmodule CadeauPlatform.Inventory.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Inventory.{Category, Product}


  schema "categories" do
    field :name, :string
    field :type, CategoryTypeEnum
    has_many :products, Product
    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> Ecto.Changeset.cast(attrs, [:name, :type])
    |> validate_required([:name, :type])
  end
end

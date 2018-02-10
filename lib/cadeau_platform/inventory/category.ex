defmodule CadeauPlatform.Inventory.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Inventory.{Category, Product}
  import EctoEnum

  defenum CategoryTypeEnum, book: 0, medical: 1, food: 2, wear: 3

  schema "categories" do
    field :name, :string
    field :type, CategoryTypeEnum
    has_many :products, Product
    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [])
    |> validate_required([])
  end
end

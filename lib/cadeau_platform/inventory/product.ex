defmodule CadeauPlatform.Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Inventory.{Product, Category, Tax, ProductTax}


  schema "products" do
    field :name, :string
    field :price_cents, Money.Ecto.Type
    field :description, :string
    field :imported, :boolean, default: false
    field :image_link, :string
    belongs_to :category, Category
    many_to_many :taxes, Tax, join_through: ProductTax

    timestamps()
  end

  @doc false
  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [:name, :price_cents, :description, :imported, :image_link, :category_id])
    |> validate_required([:name, :price_cents, :description, :image_link])
  end
end

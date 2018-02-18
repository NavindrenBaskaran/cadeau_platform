defmodule CadeauPlatform.Shopping.Cart do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Shopping.{Cart, CartProduct}
  alias CadeauPlatform.Accounts.User
  alias CadeauPlatform.Inventory.Product

  schema "carts" do
    belongs_to :user, User
    many_to_many :products, Product, join_through: CartProduct
    timestamps()
  end

  @doc false
  def changeset(%Cart{} = cart, attrs) do
    cart
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
    |> unique_constraint(:user_id)
  end
end

defmodule CadeauPlatform.Shopping.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Shopping.Order
  alias CadeauPlatform.Account.User

  schema "orders" do
    belongs_to :user, User
    field :chargeable_amount, Money.Ecto.Type
    timestamps()
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [])
    |> validate_required([])
  end
end

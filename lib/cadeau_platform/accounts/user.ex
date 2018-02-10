defmodule CadeauPlatform.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias CadeauPlatform.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :password_digest, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [])
    |> validate_required([])
  end
end

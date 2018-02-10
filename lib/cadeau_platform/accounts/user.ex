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
    |> cast(attrs, [:email, :name, :password_digest])
    |> validate_required([:email, :name, :password_digest])
  end

  def registration_changeset(%User{} = user, attrs) do
    user
      |> cast(attrs, [:name, :email, :password, :password_confirmation])
      |> validate_changeset()
      |> generate_password_hash()
  end

  defp validate_changeset(changeset) do
    changeset
      |> validate_required([:name, :email, :password, :password_confirmation])
      |> validate_confirmation(:password)
      |> validate_format(:email, ~r/@/)
      |> unique_constraint(:email)
  end

  defp generate_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_digest, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end

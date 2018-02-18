defmodule CadeauPlatform.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias CadeauPlatform.Repo

  alias CadeauPlatform.Accounts.User

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(params) do
    email = params["email"]
    password = params["password"]

    user = Repo.get_by(User, email: email)

    case user do
      nil ->
        false
      _ ->
        { Comeonin.Bcrypt.checkpw(password, user.password_digest), user.id }
    end
  end

end

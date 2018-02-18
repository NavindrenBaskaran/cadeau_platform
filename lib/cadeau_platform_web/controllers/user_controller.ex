defmodule CadeauPlatformWeb.UserController do
  use CadeauPlatformWeb, :controller

  alias CadeauPlatform.Accounts
  alias CadeauPlatform.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        conn
         |> put_session(:current_user_id, user.id)
         |> redirect(to: page_path(conn, :index))
    {:error, changeset} ->
        conn
         |> put_flash(:error, "Error")
         |> render("new.html", changeset: changeset)
    end
  end
end

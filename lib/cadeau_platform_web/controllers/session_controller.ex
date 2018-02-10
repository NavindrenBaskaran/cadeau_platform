defmodule CadeauPlatformWeb.SessionController do
  use CadeauPlatformWeb, :controller

  alias CadeauPlatform.Accounts

  def new(conn, _params) do
    case get_session(conn, :current_user) do
      nil ->
        render(conn, "new.html")
      user ->
        redirect(conn, to: page_path(conn, :index))
    end
  end

  def create(conn, %{"session" => params}) do
    case Accounts.authenticate_user(params) do
      { true, user } ->
        redirect(login(conn, user), to: page_path(conn, :index))
      false ->
        conn
        |> put_flash(:error, "Invalid Credentials")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
     |> delete_session(:current_user)
     |> put_session(:info, "Successfully Signed Out")
     |> redirect(to: page_path(conn, :index))
  end

  defp login(conn, user) do
    conn
    |> put_session(:current_user, user)
  end

end

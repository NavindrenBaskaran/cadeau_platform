defmodule CadeauPlatformWeb.SessionController do
  use CadeauPlatformWeb, :controller

  alias CadeauPlatform.Accounts

  def new(conn, _params) do
    case get_session(conn, :current_user_id) do
      nil ->
        render(conn, "new.html")
      user ->
        redirect(conn, to: page_path(conn, :index))
    end
  end

  def create(conn, %{"session" => params}) do
    case Accounts.authenticate_user(params) do
      { true, user_id } ->
        redirect(login(conn, user_id), to: page_path(conn, :index))
      { false , user_id} ->
        conn
        |> put_flash(:error, "Invalid Credentials")
        |> render("new.html")
      false ->
        conn
        |> put_flash(:error, "Invalid Credentials")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
     |> delete_session(:current_user_id)
     |> delete_session(:cart_id)
     |> put_session(:info, "Successfully Signed Out")
     |> redirect(to: page_path(conn, :index))
  end

  defp login(conn, user_id) do
    conn
    |> put_session(:current_user_id, user_id)
  end

end

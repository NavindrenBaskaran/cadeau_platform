defmodule CadeauPlatform.Plugs.CurrentUser do
  alias Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case Conn.get_session(conn, :current_user) do
      nil ->
        conn
         |> Conn.assign(:user, false)
         |> Conn.assign(:authenticated, :false)
      user ->
        conn
         |> Conn.assign(:user, user)
         |> Conn.assign(:authenticated, true)
    end
  end
end

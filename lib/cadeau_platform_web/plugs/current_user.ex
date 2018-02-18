defmodule CadeauPlatform.Plugs.CurrentUser do
  alias Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case Conn.get_session(conn, :current_user_id) do
      nil ->
        conn
         |> Conn.assign(:user_id, false)
         |> Conn.assign(:authenticated, :false)
      user_id ->
        conn
         |> Conn.assign(:user_id, user_id)
         |> Conn.assign(:authenticated, true)
    end
  end
end

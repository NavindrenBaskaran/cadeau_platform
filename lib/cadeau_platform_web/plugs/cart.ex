defmodule CadeauPlatform.Plugs.Cart do
  import Plug.Conn
  alias CadeauPlatform.Shopping


  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with true <- conn.assigns.authenticated,
         true <- Kernel.is_nil(get_session(conn, :cart_id))
    do
      get_cart(conn)
    else
      _ ->
        assign(conn, :cart_id, get_session(conn, :cart_id))
    end
  end

  defp get_cart(conn) do
    case  Kernel.is_nil(Shopping.get_cart_by_user_id(conn.assigns.user_id)) do
      true ->
        create_cart(conn)
      false ->
        cart = Shopping.get_cart_by_user_id(conn.assigns.user_id)
        conn
        |> put_session(:cart_id, cart.id)
        |> assign(:cart_id, cart.id)
    end
  end

  defp create_cart(conn) do
    {_ , cart} = Shopping.create_cart(%{user_id: conn.assigns.user_id})
    conn
    |> put_session(:cart_id, cart.id)
    |> assign(:cart_id, cart.id)
  end
end

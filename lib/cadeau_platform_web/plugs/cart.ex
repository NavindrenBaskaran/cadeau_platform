defmodule CadeauPlatform.Plugs.Cart do
  import Plug.Conn
  alias CadeauPlatform.Shopping


  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case get_session(conn, :cart) do
      nil ->
        {_ , cart} = Shopping.create_cart()
        conn = conn |> put_session(:cart, cart.id)
        assign(conn, :cart, cart)
      _ ->
        cart = Shopping.get_cart(get_session(conn, :cart))
        assign(conn, :cart, cart.id)
    end
  end
end

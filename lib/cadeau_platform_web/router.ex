defmodule CadeauPlatformWeb.Router do
  use CadeauPlatformWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CadeauPlatform.Plugs.CurrentUser
    plug CadeauPlatform.Plugs.Cart
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CadeauPlatformWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    get "/login", SessionController , :new
    post "/login", SessionController , :create
    delete "/logout", SessionController , :delete
    resources "/shopping_cart", ShoppingCartController
    post "/shopping_cart/add", ShoppingCartController, :add
    resources "/order", OrderController
    post "/order/create_order", OrderController, :create_order
  end

  # Other scopes may use custom stacks.
  # scope "/api", CadeauPlatformWeb do
  #   pipe_through :api
  # end
end

defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Server.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/z", ServerWeb do
    pipe_through [:browser, Server.CanProceed]

    get "/test", ZController, :index
  end

  scope "/", ServerWeb do
    pipe_through :browser
    get "/users", UserController, :index
    post "/users", UserController, :create
    get "/users/:id", UserController, :show
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ServerWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ServerWeb.Telemetry
    end
  end
end
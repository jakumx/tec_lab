defmodule TecLab.Router do
  use TecLab.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TecLab do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/new", PageController, :new
    get "/new", PageController, :new
    get "/find", FindController, :index
    post "/find/new", FindController, :new
    get "/find/new", FindController, :new
    # resources "/find", FindController, only: [:index, :new]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TecLab do
  #   pipe_through :api
  # end
end

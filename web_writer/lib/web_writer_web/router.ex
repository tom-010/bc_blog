defmodule WebWriterWeb.Router do
  use WebWriterWeb, :router

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

  scope "/", WebWriterWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/new", PageController, :new 
    post "/save", PageController, :save 
    put "/save", PageController, :save
    get "/update", PageController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebWriterWeb do
  #   pipe_through :api
  # end
end

defmodule Fpb.Router do
  use Fpb.Web, :router

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

  scope "/", Fpb do
    pipe_through :browser

    get "/", ClubsController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Fpb do
  #   pipe_through :api
  # end
end

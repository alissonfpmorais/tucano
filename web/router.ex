defmodule Tucano.Router do
  use Tucano.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Tucano.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tucano do
    pipe_through :browser # Use the default browser stack

  end

  # Other scopes may use custom stacks.
  # scope "/api", Tucano do
  #   pipe_through :api
  # end
end

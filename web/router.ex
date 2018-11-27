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

    get "/", AuthController, :login
    resources "/servico", ServicoController
    resources "/banco", BancoController
    resources "/etapa", EtapaController
    resources "/prioridade", PrioridadeController
    resources "/status", StatusController
    resources "/tipo_pagamento", TipoPagamentoController
  end

  scope "/auth", Tucano do
    pipe_through :browser

    get "/login", AuthController, :login
    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Tucano do
  #   pipe_through :api
  # end
end

defmodule Tucano.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias Tucano.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:funcionario] do
      conn
    else
      conn
      |> put_flash(:error, "Você presica estar logado!")
      |> redirect(to: Helpers.auth_path(conn, :login))
      |> halt
    end
  end
end

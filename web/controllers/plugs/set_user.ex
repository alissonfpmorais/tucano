defmodule Tucano.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Tucano.Repo
  alias Tucano.Funcionario

  def init(_params) do
  end

  def call(conn, params) do
    id = get_session(conn, :funcionario_id)

    cond do
      funcionario = id && Funcionario.get_by_id(id) -> assign(conn, :funcionario, funcionario)
      true -> assign(conn, :funcionario, nil)
    end
  end
end

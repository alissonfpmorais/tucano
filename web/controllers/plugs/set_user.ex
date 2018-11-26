defmodule Tucano.Plugs.SetUser do
  import Plug.Conn

  alias Tucano.Funcionario

  def init(_params) do
  end

  def call(conn, _params) do
    id = get_session(conn, :funcionario_id)

    cond do
      funcionario = id && Funcionario.get_by_id(id) -> assign(conn, :funcionario, funcionario)
      true -> assign(conn, :funcionario, nil)
    end
  end
end

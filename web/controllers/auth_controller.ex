defmodule Tucano.AuthController do
  use Tucano.Web, :controller
  plug Ueberauth

  alias Tucano.Funcionario

  def login(conn, _params) do
    case conn.assigns.funcionario do
      nil -> render(conn, "login.html")
      funcionario -> redirect(conn, to: servico_path(conn, :index))
    end
  end

  def signout(conn, _params) do
    conn
    |> put_flash(:info, "Logout Successful!")
    |> clear_session
    |> redirect(to: servico_path(conn, :index))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    response =
      %{nome: auth.info.name, email: auth.info.email, provedor: provider, token: auth.credentials.token}
      |> Funcionario.insert_or_update

    sign_in(conn, response)
  end

  defp sign_in(conn, response) do
    IO.inspect response

    case response do
      {:ok, funcionario} ->
        conn
        |> put_flash(:info, "Autenticação realizada com sucesso!")
        |> put_session(:funcionario_id, funcionario.id)
        |> redirect(to: servico_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Erro durante o processo de autenticação!")
        |> redirect(to: auth_path(conn, :login))
    end
  end
end

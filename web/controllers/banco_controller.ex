defmodule Tucano.BancoController do
  use Tucano.Web, :controller

  plug Tucano.Plugs.RequireAuth

  alias Tucano.Banco

  def index(conn, _params) do
    bancos = Banco.get_all
    render conn, "index.html", bancos: bancos
  end

  def new(conn, _params) do
    changeset = Banco.from_blank
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"banco" => banco}) do
    case Banco.insert(banco) do
      {:ok, banco} ->
        conn
        |> put_flash(:info, "Criação realizada com sucesso!")
        |> redirect(to: banco_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de criação!")
        |> render "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => banco_id}) do
    banco = Banco.get_by_id(banco_id)
    changeset = Banco.changeset(banco)

    render conn, "edit.html", changeset: changeset, banco: banco
  end

  def update(conn, %{"id" => banco_id, "banco" => banco}) do
    case Banco.update(banco_id, banco) do
      {:ok, _banco} ->
        conn
        |> put_flash(:info, "Atualização realizada com sucesso!")
        |> redirect(to: banco_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de atualização!")
        |> render "edit.html", changeset: changeset, banco: Banco.get_by_id(banco_id)
    end
  end

  def delete(conn, %{"id" => banco_id}) do
    Banco.delete!(banco_id)

    conn
    |> put_flash(:info, "Remoção realizada com sucesso!")
    |> redirect(to: banco_path(conn, :index))
  end

  def show(conn, _params) do
    TODO
  end
end

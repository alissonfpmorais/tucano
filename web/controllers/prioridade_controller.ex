defmodule Tucano.PrioridadeController do
  use Tucano.Web, :controller

  plug Tucano.Plugs.RequireAuth

  alias Tucano.Prioridade

  def index(conn, _params) do
    prioridades =
      Prioridade.get_all
      |> Enum.sort(&(&1.numero <= &2.numero))
      
    render conn, "index.html", prioridades: prioridades
  end

  def new(conn, _params) do
    changeset = Prioridade.from_blank
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"prioridade" => prioridade}) do
    case Prioridade.insert(prioridade) do
      {:ok, _prioridade} ->
        conn
        |> put_flash(:info, "Criação realizada com sucesso!")
        |> redirect(to: prioridade_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de criação!")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => prioridade_id}) do
    prioridade = Prioridade.get_by_id(prioridade_id)
    changeset = Prioridade.changeset(prioridade)

    render conn, "edit.html", changeset: changeset, prioridade: prioridade
  end

  def update(conn, %{"id" => prioridade_id, "prioridade" => prioridade}) do
    case Prioridade.update(prioridade_id, prioridade) do
      {:ok, _prioridade} ->
        conn
        |> put_flash(:info, "Atualização realizada com sucesso!")
        |> redirect(to: prioridade_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de atualização!")
        |> render("edit.html", changeset: changeset, prioridade: Prioridade.get_by_id(prioridade_id))
    end
  end

  def delete(conn, %{"id" => prioridade_id}) do
    Prioridade.delete!(prioridade_id)

    conn
    |> put_flash(:info, "Remoção realizada com sucesso!")
    |> redirect(to: prioridade_path(conn, :index))
  end

  def show(conn, _params) do
    conn
  end
end


defmodule Tucano.EtapaController do
  use Tucano.Web, :controller

  plug Tucano.Plugs.RequireAuth

  alias Tucano.Etapa

  def index(conn, _params) do
    etapas = Etapa.get_all
    render conn, "index.html", etapas: etapas
  end

  def new(conn, _params) do
    changeset = Etapa.from_blank
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"etapa" => etapa}) do
    case Etapa.insert(etapa) do
      {:ok, _etapa} ->
        conn
        |> put_flash(:info, "Criação realizada com sucesso!")
        |> redirect(to: etapa_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de criação!")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => etapa_id}) do
    etapa = Etapa.get_by_id(etapa_id)
    changeset = Etapa.changeset(etapa)

    render conn, "edit.html", changeset: changeset, etapa: etapa
  end

  def update(conn, %{"id" => etapa_id, "etapa" => etapa}) do
    case Etapa.update(etapa_id, etapa) do
      {:ok, _etapa} ->
        conn
        |> put_flash(:info, "Atualização realizada com sucesso!")
        |> redirect(to: etapa_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de atualização!")
        |> render("edit.html", changeset: changeset, etapa: Etapa.get_by_id(etapa_id))
    end
  end

  def delete(conn, %{"id" => etapa_id}) do
    Etapa.delete!(etapa_id)

    conn
    |> put_flash(:info, "Remoção realizada com sucesso!")
    |> redirect(to: etapa_path(conn, :index))
  end

  def show(conn, _params) do
    conn
  end
end

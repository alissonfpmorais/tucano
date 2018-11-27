defmodule Tucano.StatusController do
  use Tucano.Web, :controller

  plug Tucano.Plugs.RequireAuth

  alias Tucano.Status

  def index(conn, _params) do
    statuses =
      Status.get_all
      |> Enum.sort(&(&1.nome <= &2.nome))

    render conn, "index.html", statuses: statuses
  end

  def new(conn, _params) do
    changeset = Status.from_blank
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"status" => status}) do
    case Status.insert(status) do
      {:ok, _status} ->
        conn
        |> put_flash(:info, "Criação realizada com sucesso!")
        |> redirect(to: status_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de criação!")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => status_id}) do
    status = Status.get_by_id(status_id)
    changeset = Status.changeset(status)

    render conn, "edit.html", changeset: changeset, status: status
  end

  def update(conn, %{"id" => status_id, "status" => status}) do
    case Status.update(status_id, status) do
      {:ok, _status} ->
        conn
        |> put_flash(:info, "Atualização realizada com sucesso!")
        |> redirect(to: status_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de atualização!")
        |> render("edit.html", changeset: changeset, status: Status.get_by_id(status_id))
    end
  end

  def delete(conn, %{"id" => status_id}) do
    Status.delete!(status_id)

    conn
    |> put_flash(:info, "Remoção realizada com sucesso!")
    |> redirect(to: status_path(conn, :index))
  end

  def show(conn, _params) do
    conn
  end
end

defmodule Tucano.TipoPagamentoController do
  use Tucano.Web, :controller

  plug Tucano.Plugs.RequireAuth

  alias Tucano.TipoPagamento

  def index(conn, _params) do
    tipos_pagamento =
      TipoPagamento.get_all
      |> Enum.sort(&(&1.tipo <= &2.tipo))

    render conn, "index.html", tipos_pagamento: tipos_pagamento
  end

  def new(conn, _params) do
    changeset = TipoPagamento.from_blank
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"tipo_pagamento" => tipo_pagamento}) do
    case TipoPagamento.insert(tipo_pagamento) do
      {:ok, _tipo_pagamento} ->
        conn
        |> put_flash(:info, "Criação realizada com sucesso!")
        |> redirect(to: tipo_pagamento_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de criação!")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => tipo_pagamento_id}) do
    tipo_pagamento = TipoPagamento.get_by_id(tipo_pagamento_id)
    changeset = TipoPagamento.changeset(tipo_pagamento)

    render conn, "edit.html", changeset: changeset, tipo_pagamento: tipo_pagamento
  end

  def update(conn, %{"id" => tipo_pagamento_id, "tipo_pagamento" => tipo_pagamento}) do
    case TipoPagamento.update(tipo_pagamento_id, tipo_pagamento) do
      {:ok, _tipo_pagamento} ->
        conn
        |> put_flash(:info, "Atualização realizada com sucesso!")
        |> redirect(to: tipo_pagamento_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Erro no processo de atualização!")
        |> render("edit.html", changeset: changeset, tipo_pagamento: TipoPagamento.get_by_id(tipo_pagamento_id))
    end
  end

  def delete(conn, %{"id" => tipo_pagamento_id}) do
    TipoPagamento.delete!(tipo_pagamento_id)

    conn
    |> put_flash(:info, "Remoção realizada com sucesso!")
    |> redirect(to: tipo_pagamento_path(conn, :index))
  end

  def show(conn, _params) do
    conn
  end
end

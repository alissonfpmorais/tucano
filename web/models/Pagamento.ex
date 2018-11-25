defmodule Tucano.Pagamento do
  use Tucano.Web, :model

  schema "pagamento" do
    field :valor, :integer
    belongs_to :tipo_pagamento, Tucano.TipoPagamento
    belongs_to :banco, Tucano.Banco
    belongs_to :servico, Tucano.Servico

    timestamps()
  end

  def changeset(%Tucano.Pagamento{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:valor])
    |> validate_required([:valor])
  end
end

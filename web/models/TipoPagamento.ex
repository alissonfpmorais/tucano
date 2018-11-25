defmodule Tucano.TipoPagamento do
  use Tucano.Web, :model

  schema "tipo_pagamento" do
    field :tipo, :string
    has_many :pagamento, Tucano.Pagamento

    timestamps()
  end

  def changeset(%Tucano.TipoPagamento{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:tipo])
    |> validate_required([:tipo])
    |> cast_assoc(:pagamento)
  end
end

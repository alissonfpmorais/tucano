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
    |> validate_required([:valor], "Campo não pode estar vazio!")
    |> validate_number(:valor, greater_than_or_equal_to: 0, message: "Não são aceitos valores negativos!")
    |> cast_assoc(:tipo_pagamento)
    |> cast_assoc(:banco)
    |> cast_assoc(:servico)
  end
end

defmodule Tucano.Pedido do
  use Tucano.Web, :model

  schema "pedido" do
    field :nome, :string
    field :quantidade, :integer
    field :valor, :integer
    field :descricao, :string
    field :observacao, :string
    belongs_to :etapa, Tucano.Etapa
    belongs_to :servico, Tucano.Servico

    timestamps()
  end

  def changeset(%Tucano.Pedido{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :quantidade, :valor, :descricao])
    |> validate_required([:nome, :quantidade, :valor, :descricao])
  end
end

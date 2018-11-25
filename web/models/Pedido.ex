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
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> validate_number(:quantidade, greater_than_or_equal_to: 1, message: "Não é possível criar pedidos com 0 itens!")
    |> validate_number(:valor, greater_than_or_equal_to: 0, message: "Não são aceitos valores negativos!")
    |> cast_assoc(:etapa)
    |> cast_assoc(:servico)
  end
end

defmodule Tucano.Servico do
  use Tucano.Web, :model

  schema "servico" do
    field :data_inicio, :date
    field :data_envio, :date
    field :codigo_postagem, :string
    field :observacao, :string
    belongs_to :prioridade, Tucano.Prioridade
    belongs_to :status, Tucano.Status
    belongs_to :cliente, Tucano.Cliente
    belongs_to :endereco, Tucano.Endereco
    has_many :pagamento, Tucano.Pagamento
    has_many :pedido, Tucano.Pedido

    timestamps()
  end

  def changeset(%Tucano.Servico{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:data_inicio, :data_envio, :codigo_postagem])
    |> cast_assoc(:prioridade)
    |> cast_assoc(:status)
    |> cast_assoc(:cliente)
    |> cast_assoc(:endereco)
    |> cast_assoc(:pagamento)
    |> cast_assoc(:pedido)
  end
end

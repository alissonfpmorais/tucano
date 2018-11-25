defmodule Tucano.Endereco do
  use Tucano.Web, :model

  schema "endereco" do
    field :rua, :string
    field :numero, :integer
    field :bairro, :string
    field :cep, :string
    field :cidade, :string
    field :estado, :string
    field :pais, :string
    field :complemento, :string
    belongs_to :cliente, Tucano.Cliente
    has_many :servico, Tucano.Servico

    timestamps()
  end

  def changeset(%Tucano.Endereco{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:rua, :numero, :bairro, :cep, :cidade, :estado, :pais, :complemento])
    |> validate_required([:rua, :numero, :bairro, :cep, :cidade, :estado, :pais], message: "Campo não pode estar vazio!")
    |> cast_assoc(:cliente)
    |> cast_assoc(:servico)
  end
end

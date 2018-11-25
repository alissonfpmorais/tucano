defmodule Tucano.Cliente do
  use Tucano.Web, :model

  schema "cliente" do
    field :nome, :string
    field :email, :string
    field :registro, :string
    field :insc_estadual, :string
    has_many :endereco, Tucano.Endereco
    has_many :telefone, Tucano.Telefone
    has_many :servico, Tucano.Servico

    timestamps()
  end

  def changeset(%Tucano.Cliente{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :email, :registro, :insc_estadual])
    |> validate_required([:nome, :email])
  end
end

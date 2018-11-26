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
    alias Tucano.Validations, as: Valids

    struct
    |> cast(params, [:nome, :email, :registro, :insc_estadual])
    |> validate_required([:nome, :email], message: "Campo não pode estar vazio!")
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> validate_format(:email, Valids.get_regex_of(:email), message: "Formato de e-mail inválido, ex: usuario@email.com")
    |> validate_format(:registro, Valids.get_regex_of(:registro))
    |> cast_assoc(:endereco)
    |> cast_assoc(:telefone)
    |> cast_assoc(:servico)
  end
end

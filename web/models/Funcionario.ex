defmodule Tucano.Funcionario do
  use Tucano.Web, :model

  alias Tucano.Repo

  schema "funcionario" do
    field :nome, :string
    field :email, :string
    field :provedor, :string
    field :token, :string

    timestamps()
  end

  def changeset(%Tucano.Funcionario{} = struct, params \\ %{}) do
    alias Tucano.Regex

    struct
    |> cast(params, [:nome, :email, :provedor, :token])
    |> validate_required([:nome, :email, :provedor, :token], message: "Campo não pode estar vazio!")
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> validate_format(:email, Regex.get_regex_of(:email), message: "Formato de e-mail inválido, ex: usuario@email.com")
  end

  def get_by_id(id), do: Repo.get(Tucano.Funcionario, id)
end

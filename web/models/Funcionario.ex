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
    alias Tucano.Validations, as: Valids

    struct
    |> cast(params, [:nome, :email, :provedor, :token])
    |> validate_required([:nome, :email, :provedor, :token], message: "Campo não pode estar vazio!")
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> validate_format(:email, Valids.get_regex_of(:email), message: "Formato de e-mail inválido, ex: usuario@email.com")
  end

  def get_by_id(id), do: Repo.get(Tucano.Funcionario, id)

  def insert_or_update(%{email: email} = params) do
    case Repo.get_by(Tucano.Funcionario, email: email) do
      nil -> Tucano.Funcionario.changeset(%Tucano.Funcionario{}, params)
      funcionario -> Tucano.Funcionario.changeset(funcionario, params)
    end
    |> Repo.insert_or_update
  end
end

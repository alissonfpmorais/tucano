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
    struct
    |> cast(params, [:nome, :email, :provedor, :token])
    |> validate_required([:nome, :email, :provedor, :token])
  end

  def get_by_id(id), do: Repo.get(Tucano.Funcionario, id)
end

defmodule Tucano.Prioridade do
  use Tucano.Web, :model

  alias Tucano.Repo
  alias Tucano.Prioridade
  alias Tucano.Servico

  schema "prioridade" do
    field :nome, :string
    field :numero, :integer
    has_many :servico, Servico

    timestamps()
  end

  def changeset(%Prioridade{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :numero])
    |> validate_required([:nome, :numero])
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> validate_number(:numero, greater_than_or_equal_to: 0, message: "Não são aceitos valores negativos!")
    |> cast_assoc(:servico)
  end

  def from_blank(params \\ %{}), do: Prioridade.changeset(%Prioridade{}, params)

  def insert(params \\ %{}) do
    %Prioridade{}
    |> changeset(params)
    |> Repo.insert
  end

  def get_all, do: Repo.all(Prioridade)

  def get_by_id(id), do: Repo.get(Prioridade, id)

  def get_by_id!(id), do: Repo.get!(Prioridade, id)

  def preload(structs, :servico), do: Repo.preload(structs, :servico)

  def preload(structs, _), do: structs

  def update(id, params) do
    get_by_id(id)
    |> changeset(params)
    |> Repo.update
  end

  def delete(id) do
    get_by_id(id)
    |> Repo.delete
  end

  def delete!(id) do
    get_by_id!(id)
    |> Repo.delete!
  end
end

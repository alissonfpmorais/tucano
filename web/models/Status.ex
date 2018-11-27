defmodule Tucano.Status do
  use Tucano.Web, :model

  alias Tucano.Repo
  alias Tucano.Status
  alias Tucano.Servico

  schema "status" do
    field :nome, :string
    has_many :servico, Servico

    timestamps()
  end

  def changeset(%Status{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome])
    |> validate_required([:nome])
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> cast_assoc(:servico)
  end

  def from_blank(params \\ %{}), do: Status.changeset(%Status{}, params)

  def insert(params \\ %{}) do
    %Status{}
    |> changeset(params)
    |> Repo.insert
  end

  def get_all, do: Repo.all(Status)

  def get_by_id(id), do: Repo.get(Status, id)

  def get_by_id!(id), do: Repo.get!(Status, id)

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

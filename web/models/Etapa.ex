defmodule Tucano.Etapa do
  use Tucano.Web, :model

  alias Tucano.Repo
  alias Tucano.Etapa
  alias Tucano.Pedido

  schema "etapa" do
    field :nome, :string
    has_many :pedido, Pedido

    timestamps()
  end

  def changeset(%Etapa{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome])
    |> validate_required([:nome], message: "Campo não pode estar vazio!")
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> cast_assoc(:pedido)
  end

  def from_blank(params \\ %{}), do: Etapa.changeset(%Etapa{}, params)

  def insert(params \\ %{}) do
    %Etapa{}
    |> changeset(params)
    |> Repo.insert
  end

  def get_all, do: Repo.all(Etapa)

  def get_by_id(id), do: Repo.get(Etapa, id)

  def get_by_id!(id), do: Repo.get!(Etapa, id)

  def preload(structs, :pedido), do: Repo.preload(structs, :pedido)

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

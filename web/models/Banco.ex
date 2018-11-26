defmodule Tucano.Banco do
  use Tucano.Web, :model

  alias Tucano.Repo
  alias Tucano.Banco
  alias Tucano.Pagamento

  schema "banco" do
    field :nome, :string
    has_many :pagamento, Pagamento

    timestamps()
  end

  def changeset(%Banco{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome])
    |> validate_required([:nome], message: "Campo não pode estar vazio!")
    |> cast_assoc(:pagamento)
  end

  def from_blank(params \\ %{}), do: Banco.changeset(%Banco{}, params)

  def insert(params \\ %{}) do
    %Banco{}
    |> changeset(params)
    |> Repo.insert
  end

  def get_all, do: Repo.all(Banco)

  def get_by_id(id), do: Repo.get(Banco, id)

  def get_by_id!(id), do: Repo.get!(Banco, id)

  def preload(structs, :pagamento), do: Repo.preload(structs, :pagamento)

  def preload(structs, _), do: structs

  def update(id, params) do
    get_by_id(id)
    |> changeset(params)
    |> Repo.update
  end

  def delete(id) do
    Repo.get(Banco, id)
    |> Repo.delete
  end

  def delete!(id) do
    Repo.get!(Banco, id)
    |> Repo.delete!
  end
end

defmodule Tucano.TipoPagamento do
  use Tucano.Web, :model

  alias Tucano.Repo
  alias Tucano.TipoPagamento
  alias Tucano.Pagamento

  schema "tipo_pagamento" do
    field :tipo, :string
    has_many :pagamento, Pagamento

    timestamps()
  end

  def changeset(%TipoPagamento{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:tipo])
    |> validate_required([:tipo])
    |> cast_assoc(:pagamento)
  end

  def from_blank(params \\ %{}), do: TipoPagamento.changeset(%TipoPagamento{}, params)

  def insert(params \\ %{}) do
    %TipoPagamento{}
    |> changeset(params)
    |> Repo.insert
  end

  def get_all, do: Repo.all(TipoPagamento)

  def get_by_id(id), do: Repo.get(TipoPagamento, id)

  def get_by_id!(id), do: Repo.get!(TipoPagamento, id)

  def preload(structs, :pagamento), do: Repo.preload(structs, :pagamento)

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

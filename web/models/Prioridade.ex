defmodule Tucano.Prioridade do
  use Tucano.Web, :model

  schema "prioridade" do
    field :nome, :string
    field :numero, :integer
    has_many :servico, Tucano.Servico

    timestamps()
  end

  def changeset(%Tucano.Prioridade{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome, :numero])
    |> validate_required([:nome, :numero])
  end
end

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
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> validate_number(:numero, greater_than_or_equal_to: 0, message: "Não são aceitos valores negativos!")
    |> cast_assoc(:servico)
  end
end

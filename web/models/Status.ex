defmodule Tucano.Status do
  use Tucano.Web, :model

  schema "status" do
    field :nome, :string
    has_many :servico, Tucano.Servico

    timestamps()
  end

  def changeset(%Tucano.Status{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome])
    |> validate_required([:nome])
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> cast_assoc(:nome)
  end
end

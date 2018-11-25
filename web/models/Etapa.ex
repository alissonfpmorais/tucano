defmodule Tucano.Etapa do
  use Tucano.Web, :model

  schema "etapa" do
    field :nome, :string
    has_many :pedido, Tucano.Pedido

    timestamps()
  end

  def changeset(%Tucano.Etapa{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome])
    |> validate_required([:nome], message: "Campo não pode estar vazio!")
    |> validate_length(:nome, min: 2, message: "Nome deve conter pelo menos duas letras!")
    |> cast_assoc(:pedido)
  end
end

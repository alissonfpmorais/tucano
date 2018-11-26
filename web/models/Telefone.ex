defmodule Tucano.Telefone do
  use Tucano.Web, :model

  alias Tucano.Cliente

  schema "telefone" do
    field :numero, :string
    belongs_to :cliente, Cliente

    timestamps()
  end

  def changeset(%Tucano.Telefone{} = struct, params \\ %{}) do
    alias Tucano.Validations, as: Valids

    struct
    |> cast(params, [:numero])
    |> validate_required([:numero])
    |> validate_format(:numero, Valids.get_regex_of(:telefone), message: "Formato de telefone inválido, ex: (XX)99999-9999")
    |> cast_assoc(:cliente)
  end
end

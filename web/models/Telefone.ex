defmodule Tucano.Telefone do
  use Tucano.Web, :model

  alias Tucano.Cliente

  schema "telefone" do
    field :numero, :string
    belongs_to :cliente, Cliente

    timestamps()
  end

  def changeset(%Tucano.Telefone{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:numero])
    |> validate_required([:numero])
  end
end

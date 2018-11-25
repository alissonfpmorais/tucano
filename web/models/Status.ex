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
  end
end

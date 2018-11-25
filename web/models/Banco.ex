defmodule Tucano.Banco do
  use Tucano.Web, :model

  alias Tucano.Repo

  schema "banco" do
    field :nome, :string
    has_many :pagamento, Tucano.Pagamento

    timestamps()
  end

  def changeset(%Tucano.Banco{} = struct, params \\ %{}) do
    struct
    |> cast(params, [:nome])
    |> validate_required([:nome])
  end

  def insert(params \\ %{}) do
    %Tucano.Banco{}
    |> changeset(params)
    |> Repo.insert
  end
end

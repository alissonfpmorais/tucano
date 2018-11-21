defmodule Tucano.Repo.Migrations.InitialSchema do
  use Ecto.Migration

  def change do
    create table(:funcionario) do
      add :nome, :string, null: false
      add :email, :string, null: false
      add :provedor, :string, null: false
      add :token, :string, null: false

      timestamps()
    end

    create table(:cliente) do
      add :nome, :string, null: false
      add :email, :string, null: false
      add :registro, :string
      add :insc_estadual, :string

      timestamps()
    end

    create table(:telefone) do
      add :numero, :string, null: false
      add :cliente_id, references(:cliente, on_delete: :delete_all), null: false

      timestamps()
    end

    create table(:endereco) do
      add :rua, :string, null: false
      add :numero, :integer, null: false
      add :bairro, :string, null: false
      add :cep, :string, null: false
      add :cidade, :string, null: false
      add :estado, :string, null: false
      add :pais, :string, null: false
      add :complemento, :string
      add :cliente_id, references(:cliente, on_delete: :delete_all), null: false

      timestamps()
    end

    create table(:status) do
      add :nome, :string, null: false

      timestamps()
    end

    create table(:prioridade) do
      add :nome, :string, null: false
      add :numero, :integer, null: false

      timestamps()
    end

    create table(:servico) do
      add :data_inicio, :date
      add :data_envio, :date
      add :codigo_postagem, :string
      add :observacao, :string
      add :prioridade_id, references(:prioridade, on_delete: :delete_all), null: false
      add :status_id, references(:status, on_delete: :delete_all), null: false
      add :cliente_id, references(:cliente, on_delete: :delete_all), null: false
      add :endereco_id, references(:endereco, on_delete: :delete_all), null: false

      timestamps()
    end

    create table(:etapa) do
      add :nome, :string, null: false

      timestamps()
    end

    create table(:pedido) do
      add :nome, :string, null: false
      add :quantidade, :integer, null: false
      add :valor, :integer, null: false
      add :descricao, :string, null: false
      add :observacao, :string
      add :etapa_id, references(:etapa, on_delete: :delete_all), null: false
      add :servico_id, references(:servico, on_delete: :delete_all), null: false

      timestamps()
    end

    create table(:banco) do
      add :nome, :string, null: false

      timestamps()
    end

    create table(:tipo_pagamento) do
      add :tipo, :string, null: false

      timestamps()
    end

    create table(:pagamento) do
      add :valor, :integer, null: false
      add :tipo_pagamento_id, references(:tipo_pagamento, on_delete: :delete_all), null: false
      add :banco_id, references(:banco, on_delete: :delete_all), null: false
      add :servico_id, references(:servico, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end

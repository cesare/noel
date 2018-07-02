defmodule Noel.Repo.Migrations.CreateSlackTokens do
  use Ecto.Migration

  def up do
    create table("slack_tokens") do
      add :name,        :string, null: false
      add :token,       :string, null: false
      add :description, :string, null: true

      timestamps type: :utc_datetime, updated_at: false
    end

    create index("slack_tokens", ["name"], unique: true)
  end

  def down do
    drop index("slack_tokens", ["name"])
    drop table("slack_tokens")
  end
end

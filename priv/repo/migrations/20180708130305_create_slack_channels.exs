defmodule Noel.Repo.Migrations.CreateSlackChannels do
  use Ecto.Migration

  def up do
    create table("slack_channels") do
      add :workspace, :string, null: false
      add :name,      :string, null: false

      timestamps type: :utc_datetime, updated_at: false
    end

    create index("slack_channels", ["workspace", "name"], unique: true)
  end

  def down do
    drop index("slack_channels", ["workspace", "name"])
    drop table("slack_channels")
  end
end

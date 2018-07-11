defmodule Noel.Repo.Migrations.CreateSlackWatchers do
  use Ecto.Migration

  def up do
    create table("slack_watchers") do
      add :name,             :string, null: false
      add :slack_token_id,   :integer, null: false
      add :slack_channel_id, :integer, null: false
      add :active,           :boolean, null: false, default: false

      timestamps type: :utc_datetime
    end

    create index("slack_watchers", ["name"], unique: true)
  end

  def down do
    drop index("slack_watchers", ["name"])
    drop table("slack_watchers")
  end
end

defmodule Noel.SlackWatcher do
  use Ecto.Schema
  import Ecto.Changeset
  alias Noel.Repo
  alias Noel.{SlackChannel, SlackWatcher, SlackToken}

  schema "slack_watchers" do
    belongs_to :token, SlackToken, foreign_key: :slack_token_id
    belongs_to :channel, SlackChannel, foreign_key: :slack_channel_id

    field :name,   :string
    field :active, :boolean, default: false

    timestamps type: :utc_datetime
  end

  def changeset(%SlackWatcher{} = slack_watcher, attrs) do
    slack_watcher
    |> cast(attrs, [:name, :active])
    |> put_assoc(:token, attrs[:token])
    |> put_assoc(:channel, attrs[:channel])
    |> validate_required([:token, :name])
  end

  def restore_token(slack_watcher) do
    watcher = slack_watcher |> Repo.preload(:token)
    {:ok, token} = watcher.token |> SlackToken.restore
    token
  end
end

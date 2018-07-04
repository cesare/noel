defmodule Noel.SlackWatcher do
  use Ecto.Schema
  import Ecto.Changeset
  alias Noel.{SlackWatcher, SlackToken}

  schema "slack_watchers" do
    belongs_to :token, SlackToken, foreign_key: :slack_token_id

    field :name,   :string
    field :active, :boolean, default: false

    timestamps type: :utc_datetime
  end

  def changeset(%SlackWatcher{} = slack_watcher, attrs) do
    slack_watcher
    |> cast(attrs, [:name, :active])
    |> put_assoc(:token, attrs[:token])
    |> validate_required([:token, :name])
  end
end

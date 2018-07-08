defmodule Noel.SlackChannel do
  use Ecto.Schema
  import Ecto.Changeset
  alias Noel.SlackChannel

  schema "slack_channels" do
    field :workspace, :string
    field :name,      :string

    timestamps type: :utc_datetime, updated_at: false
  end

  @required_fields ~w(workspace name)a
  def changeset(%SlackChannel{} = slack_channel, attrs) do
    slack_channel
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end

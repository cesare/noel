defmodule Noel.SlackToken do
  use Ecto.Schema
  import Ecto.Changeset
  alias Noel.SlackToken

  schema "slack_tokens" do
    field :name,        :string
    field :token,       :string
    field :description, :string

    timestamps type: :utc_datetime, updated_at: false
  end

  def changeset(%SlackToken{} = slack_token, attrs) do
    slack_token
    |> cast(attrs, [:name, :token, :description])
    |> validate_required([:name, :token])
  end
end

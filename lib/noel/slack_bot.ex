defmodule Noel.SlackBot do
  use GenServer

  alias Noel.Repo
  alias Noel.{SlackConnection, SlackToken}

  def start_link(slack_watcher) do
    name = :"#{__MODULE__}-#{slack_watcher.name}"
    slack_watcher = slack_watcher |> Repo.preload(:token)
    {:ok, token} = slack_watcher.token |> SlackToken.restore
    GenServer.start_link(__MODULE__, token, name: name)
  end

  def init(token) do
    {:ok, identity, ws} = SlackConnection.establish!(token)
    {:ok, {identity, ws}}
  end
end

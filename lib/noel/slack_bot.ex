defmodule Noel.SlackBot do
  use GenServer

  alias Noel.{SlackConnection, SlackWatcher}

  def start_link(slack_watcher) do
    name = :"#{__MODULE__}-#{slack_watcher.name}"
    token = slack_watcher |> SlackWatcher.restore_token
    GenServer.start_link(__MODULE__, token, name: name)
  end

  def init(token) do
    {:ok, identity, ws} = SlackConnection.establish!(token)
    {:ok, {identity, ws}}
  end
end

defmodule Noel.SlackBot do
  use GenServer

  alias Noel.Repo
  alias Noel.SlackToken

  def start_link(slack_watcher) do
    name = :"#{__MODULE__}-#{slack_watcher.name}"
    slack_watcher = slack_watcher |> Repo.preload(:token)
    token = slack_watcher.token
    GenServer.start_link(__MODULE__, token, name: name)
  end

  def init(slack_token) do
    {:ok, identity, ws} = connect!(slack_token)
    {:ok, {identity, ws}}
  end

  defp connect!(slack_token) do
    case authenticate(slack_token) do
      {:ok, response = %{"url" => url}} ->
        {
          :ok,
          response["self"],
          url |> websocket_connect!
        }
      {:error, message} -> {:error, message}
    end
  end

  defp authenticate(slack_token) do
    {:ok, token} = slack_token |> SlackToken.restore
    query_string = URI.encode_query(%{token: token})
    uri = "https://slack.com/api/rtm.connect?#{query_string}"
    case HTTPoison.get(uri) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> Poison.decode
      _ -> {:error, "Authentication failed"}
    end
  end

  defp websocket_connect!(uri) do
    Socket.connect!(uri)
  end
end

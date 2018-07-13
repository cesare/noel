defmodule Noel.SlackConnection do
  alias Noel.Repo
  alias Noel.SlackToken

  def establish!(token) do
    connect!(token)
  end

  defp connect!(token) do
    case authenticate(token) do
      {:ok, response = %{"url" => url}} ->
        {
          :ok,
          response["self"],
          url |> websocket_connect!
        }
      {:error, message} -> {:error, message}
    end
  end

  defp authenticate(token) do
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

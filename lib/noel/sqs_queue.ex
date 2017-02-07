alias ExAws.SQS

defmodule Noel.SqsQueue do
  def receive(queue_name) do
    SQS.receive_message(queue_name, wait_time_seconds: 20)
    |> ExAws.request
  end
end

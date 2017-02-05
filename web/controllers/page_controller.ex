defmodule Noel.PageController do
  use Noel.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

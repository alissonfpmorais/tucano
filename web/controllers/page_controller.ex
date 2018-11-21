defmodule Tucano.PageController do
  use Tucano.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

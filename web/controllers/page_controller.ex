defmodule Fpb.PageController do
  use Fpb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

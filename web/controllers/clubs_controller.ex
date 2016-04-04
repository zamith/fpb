defmodule Fpb.ClubsController do
  use Fpb.Web, :controller
  alias Fpb.Club

  def index(conn, _params) do
    query = from c in Club,
      distinct: c.website_id,
      order_by: c.website_id

    clubs = Repo.all(query)
    render conn, "index.html", clubs: clubs
  end
end

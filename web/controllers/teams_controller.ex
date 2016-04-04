defmodule Fpb.TeamsController do
  use Fpb.Web, :controller
  alias Fpb.Team

  def index(conn, _params) do
    query = from t in Team,
      distinct: t.website_id,
      order_by: t.website_id

    teams = Repo.all(query)
    render conn, "index.html", teams: teams
  end
end

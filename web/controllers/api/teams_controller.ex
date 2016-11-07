defmodule Fpb.Api.TeamsController do
  use Fpb.Web, :controller

  import Ecto.Query

  alias Fpb.Team
  alias Fpb.Repo

  def show(conn, params) do
    team = Team
      |> where(website_id: ^params[:id])
      |> Repo.one

    render conn, "index.json", team: team
  end
end

defmodule Fpb.Api.TeamsView do
  use Fpb.Web, :view

  def render("show.json", %{team: team}) do
    %{
      name: team.name,
      level: team.level,
    }
  end
end

defmodule Mix.Tasks.Scraper.Games do
  use Mix.Task
  use Fpb.Scraper.Task
  alias Fpb.Scraper
  alias Fpb.Repo
  alias Fpb.Team

  def run(args) do
    Repo.start_link
    with_hound_session fn ->
      team_id = Enum.at(args, 0)
      Scraper.Team.scrape(team_id)

      team = Repo.get_by!(Team, website_id: team_id)

      add_games(team)
    end
  end

  def add_games(team) do

  end
end

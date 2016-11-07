defmodule Mix.Tasks.Scraper.Games do
  use Mix.Task
  use Fpb.Scraper.Task
  alias Fpb.Scraper
  alias Fpb.Repo
  alias Fpb.Team
  alias Fpb.Game

  def run(args) do
    Repo.start_link
    Application.ensure_all_started(:tzdata)
    with_hound_session fn ->
      team_id = Enum.at(args, 0)
      Scraper.Team.scrape(Integer.parse(team_id) |> elem(0))

      team = Repo.get_by!(Team, website_id: team_id)

      add_games(team)
    end
  end

  def add_games(team) do
    Scraper.Team.next_games_ids
    |> Enum.each(&(add_game(&1, team)))
  end

  def add_game(game_id, team) do
    Scraper.Game.scrape(game_id)
    changeset = Game.changeset(%Game{}, %{
      home_team: team_from_repo(Scraper.Game.home_team_name, team),
      away_team: team_from_repo(Scraper.Game.away_team_name, team),
      date: game_date,
      gym: Scraper.Game.gym
    })
    Repo.insert_or_update!(changeset)
  end

  defp team_from_repo(name, team) do
    case Repo.get_by(Team, %{name: String.upcase(name), level: team.level}) do
      nil ->
        # Scraper.Game.scrape_team(name)
        Repo.insert!(%Team{name: String.upcase(name), level: team.level})
      team -> team
    end
  end

  defp game_date do
    {:ok, date} = "#{Scraper.Game.date} #{Scraper.Game.time}"
    |> Timex.parse("%d/%m/%Y %H:%M", :strftime)

    date
  end
end

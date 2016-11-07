defmodule Fpb.Scraper.Game do
  use Hound.Helpers
  alias Fpb.Scraper

  def scrape(game_id) do
    navigate_to "http://www.fpb.pt/fpb2014/!site.go?s=1&show=jog&id=#{game_id}"
  end

  def home_team_name do
    find_element(:xpath, "//div[@class='JOG_Header']//div[@class='Centro']//table[not(ancestor::table)]/tbody/tr/td[1]")
    |> visible_text
  end

  def away_team_name do
    find_element(:xpath, "//div[@class='JOG_Header']//div[@class='Centro']//table[not(ancestor::table)]/tbody/tr/td[last()]")
    |> visible_text
  end

  def date do
    find_element(:xpath, "//table[@class='JOG_Infox']//th[.='Data:']/following-sibling::td[1]")
    |> visible_text
  end

  def time do
    find_element(:xpath, "//table[@class='JOG_Infox']//th[.='Hora:']/following-sibling::td[1]")
    |> visible_text
    |> String.replace(".", ":")
  end

  def gym do
    find_element(:xpath, "//table[@class='JOG_Infox']//td[.='Recinto:']/following-sibling::td[1]/a")
    |> attribute_value("href")
  end

  def scrape_team(team_name) do
    team_name
    |> url_from_team_name
    |> Scraper.Team.scrape

    Scraper.Team.add_current_team
  end

  defp url_from_team_name(team_name) do
    team_name = if team_name == "Illiabum /Master" do
      "Illiabum  /Master"
    end

    find_element(:xpath, "//a[.='#{team_name}']")
    |> attribute_value("href")
  end
end

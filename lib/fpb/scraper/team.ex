defmodule Fpb.Scraper.Team do
  use Fpb.Scraper.EntityWithGames

  def scrape(team_id) when is_integer(team_id) do
    navigate_to("http://www.fpb.pt/fpb2014/!site.go?s=1&show=equ&id=#{team_id}")
  end

  def scrape(team_url) do
    navigate_to(team_url)
  end

  def add_current_team do
    find_element(:xpath, "//a[.='Ver clube']")
    |> extract_id_from_anchor
    |> Mix.Tasks.Scraper.Teams.add_club
  end

  def level do
    find_element(:xpath, "//span[contains(.,'Nivel Competitivo')]/following-sibling::span[@class='Info']")
    |> visible_text
  end

  def next_games_ids do
    find_all_elements(:xpath, "//div[@id='dEquipa_Ficha_Home_Cal']//td[1]/a")
    |> Enum.map(&extract_id_from_anchor/1)
  end

  defp last_game_played_date_xpath do
    "//div[@id='dEquipa_Ficha_Home_Jog']//tr[2]/td[count(//div[@id='dEquipa_Ficha_Home_Jog']//td[.='Data/Hora']/preceding-sibling::td)+3]"
  end

  defp extract_id_from_anchor(anchor_element) do
    href = anchor_element
    |> attribute_value("href")

    Regex.run(~r/id=(\d+)/, href)
    |> Enum.at(1)
    |> String.to_integer
  end
end

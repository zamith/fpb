defmodule Fpb.Scraper.Club do
  use Fpb.Scraper.EntityWithGames

  def scrape(club_id) do
    navigate_to("http://www.fpb.pt/fpb2014/!site.go?s=1&show=clu&id=#{club_id}")
  end

  def logo do
    attribute_value({:css, "#Logo img"}, "src")
  end

  def interesting_team_ids do
    find_all_elements(:css, "#dClube_Ficha_Home_Equipas a")
    |> Enum.map(&(attribute_value(&1, "href")))
    |> Enum.map(&(Regex.run(~r/id=(\d+)/, &1) |> Enum.at(1) |> String.to_integer))
  end

  defp last_game_played_date_xpath do
    "//div[@id='d_Clube_UltimosJogos']//tr[2]/td[count(//div[@id='d_Clube_UltimosJogos']//td[.='Data']/preceding-sibling::td)+1]"
  end
end

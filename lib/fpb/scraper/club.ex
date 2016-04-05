defmodule Fpb.Scraper.Club do
  use Hound.Helpers
  use Timex

  def scrape(club_id) do
    navigate_to("http://www.fpb.pt/fpb2014/!site.go?s=1&show=clu&id=#{club_id}")
    page_source
  end

  def name do
    find_element(:css, "#NomeClube")
    |> visible_text
  end

  def logo do
    attribute_value({:css, "#Logo img"}, "src")
  end

  def interesting_team_ids do
    find_all_elements(:css, "#dClube_Ficha_Home_Equipas a")
    |> Enum.map(&(attribute_value(&1, "href")))
  end

  def active? do
    case last_game_played_date do
      {:ok, date} -> less_than_a_year_ago?(date)
      _ -> false
    end
  end

  defp less_than_a_year_ago?(date) do
    Time.diff(Date.to_timestamp(Date.today), DateTime.to_timestamp(date), :days) <= 365
  end

  defp last_game_played_date do
    find_element(:xpath, last_game_played_date_xpath)
    |> visible_text
    |> Timex.parse("%d/%m/%Y", :strftime)
  end

  defp last_game_played_date_xpath do
    "//div[@id='d_Clube_UltimosJogos']//tr[2]/td[count(//div[@id='d_Clube_UltimosJogos']//td[.='Data']/preceding-sibling::td)+1]"
  end
end

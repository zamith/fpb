defmodule Fpb.Scraper.Team do
  use Fpb.Scraper.EntityWithGames

  def scrape(team_id) do
    navigate_to("http://www.fpb.pt/fpb2014/!site.go?s=1&show=equ&id=#{team_id}")
  end

  def name do
    find_element(:css, "#NomeClube")
    |> visible_text
  end

  def level do
    find_element(:xpath, "//span[contains(.,'Nivel Competitivo')]/following-sibling::span[@class='Info']")
    |> visible_text
  end

  defp last_game_played_date_xpath do
    "//div[@id='dEquipa_Ficha_Home_Jog']//tr[2]/td[count(//div[@id='dEquipa_Ficha_Home_Jog']//td[.='Data/Hora']/preceding-sibling::td)+3]"
  end
end

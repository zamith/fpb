defmodule Fpb.Scraper.Team do
  use Hound.Helpers

  def scrape(team_id) do
    navigate_to("http://www.fpb.pt/fpb2014/!site.go?s=1&show=equ&id=#{team_id}")
  end

  def name do
    find_element(:css, "#NomeClube")
    |> visible_text
  end

  def logo do
    attribute_value({:css, "#Logo img"}, "src")
  end

  def level do
    find_element(:xpath, "//span[contains(.,'Nivel Competitivo')]/following-sibling::span[@class='Info']")
    |> visible_text
  end
end

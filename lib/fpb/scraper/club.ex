defmodule Fpb.Scraper.Club do
  use Hound.Helpers

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
end

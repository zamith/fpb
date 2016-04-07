defmodule Fpb.Scraper.EntityWithGames do
  use Timex

  defmacro __using__(_opts) do
    quote do
      use Hound.Helpers
      use Timex

      def name do
        find_element(:css, "#NomeClube")
        |> visible_text
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
      rescue
        e in RuntimeError -> {:error, e}
      end
    end
  end
end

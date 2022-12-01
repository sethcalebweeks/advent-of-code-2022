defmodule AOC do

  defmacro __using__(_opts) do
    quote do
      use Pex

      def input(day) do
        HTTPoison.get("https://adventofcode.com/2022/day/#{day}/input", %{}, hackney: [
          cookie: ["session=#{System.get_env("session", "")}; logged_in=true"]
        ])
        ~> Map.get(:body)
        ~> String.trim()
      end

    end
  end

end

defmodule Day06 do
  use AOC

  def first_marker(input, marker_length) do
    input
    |> String.to_charlist
    |> Enum.reduce({0, [], false}, fn char, {count, window, stop} ->
      cond do
        stop -> {count, window, true}
        length(window) < marker_length -> {count + 1, window ++ [char], false}
        length(Enum.uniq(window)) == marker_length -> {count, window, true}
        true -> {count + 1, Enum.slice(window, 1, marker_length - 1) ++ [char], false}
      end
    end)
    |> elem(0)
  end

  def part1, do: input(6) |> first_marker(4)

  def part2, do: input(6) |> first_marker(14)

end

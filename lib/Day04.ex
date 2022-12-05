defmodule Day04 do
  use AOC

  def part1 do
    input(4)
    ~> String.split("\n")
    ~> Enum.map(fn pair ->
      ends = Regex.named_captures(~r/(?<l1>.*)-(?<h1>.*),(?<l2>.*)-(?<h2>.*)/, pair)
      ~> Map.new(fn {key, value} -> {String.to_atom(key), String.to_integer(value)} end)
      (ends.l1 <= ends.l2 && ends.h1 >= ends.h2) ||
      (ends.l2 <= ends.l1 && ends.h2 >= ends.h1)
    end)
    ~> Enum.count(&Function.identity(&1))
  end

  def part2 do
    input(4)
    ~> String.split("\n")
    ~> Enum.map(fn pair ->
      ends = Regex.named_captures(~r/(?<l1>.*)-(?<h1>.*),(?<l2>.*)-(?<h2>.*)/, pair)
      ~> Map.new(fn {key, value} -> {String.to_atom(key), String.to_integer(value)} end)
      (ends.l1 >= ends.l2 && ends.l1 <= ends.h2) ||
      (ends.h1 >= ends.l2 && ends.h1 <= ends.h2) ||
      (ends.l2 >= ends.l1 && ends.l2 <= ends.h1) ||
      (ends.h2 >= ends.l1 && ends.h2 <= ends.h1)
    end)
    ~> Enum.count(&Function.identity(&1))
  end

end

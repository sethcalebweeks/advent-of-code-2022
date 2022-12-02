defmodule Day02 do
  use AOC

  def part1 do
    input(2)
    ~> String.split("\n")
    ~> Enum.map(fn round ->
      case round ~> String.split(" ") do
        ["A", "X"] -> 4
        ["B", "X"] -> 1
        ["C", "X"] -> 7
        ["A", "Y"] -> 8
        ["B", "Y"] -> 5
        ["C", "Y"] -> 2
        ["A", "Z"] -> 3
        ["B", "Z"] -> 9
        ["C", "Z"] -> 6
      end
    end)
    ~> Enum.sum()
  end

  def part2 do
    input(2)
    ~> String.split("\n")
    ~> Enum.map(fn round ->
      case round ~> String.split(" ") do
        ["A", "X"] -> 3
        ["B", "X"] -> 1
        ["C", "X"] -> 2
        ["A", "Y"] -> 4
        ["B", "Y"] -> 5
        ["C", "Y"] -> 6
        ["A", "Z"] -> 8
        ["B", "Z"] -> 9
        ["C", "Z"] -> 7
      end
    end)
    ~> Enum.sum()
  end

end

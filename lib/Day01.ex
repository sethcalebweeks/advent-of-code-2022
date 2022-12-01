defmodule Day01 do
  use AOC

  def part1 do
    input(1)
    ~> String.split("\n\n")
    ~> Enum.map(fn elf ->
      elf
      ~> String.split("\n")
      ~> Enum.reduce(0, fn a, b -> String.to_integer(a) + b end)
    end)
    ~> Enum.max()
  end

  def part2 do
    input(1)
    ~> String.split("\n\n")
    ~> Enum.map(fn elf ->
      elf
      ~> String.split("\n")
      ~> Enum.reduce(0, fn a, b -> String.to_integer(a) + b end)
    end)
    ~> Enum.sort(:desc)
    ~> Enum.slice(0, 3)
    ~> Enum.reduce(0, fn a, b -> a + b end)
  end

end

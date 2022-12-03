defmodule Day03 do
  use AOC

  def value(code) when code in ?a..?z, do: code - 96
  def value(code) when code in ?A..?Z, do: code - 38

  def part1 do
    input(3)
    ~> String.split("\n")
    ~> Enum.map(fn sack ->
      middle = div(String.length(sack), 2)
      {first, second} = String.split_at(sack, middle)
      first
      ~> String.to_charlist()
      ~> Enum.reduce(false, fn
        _, acc when is_integer(acc) -> acc
        char, _ -> String.contains?(second, <<char>>) && value(char)
      end)
    end)
    ~> Enum.sum
  end

  def part2 do
    input(3)
    ~> String.split("\n")
    ~> Enum.chunk_every(3)
    ~> Enum.map(fn chunk ->
        chunk
        ~> Enum.flat_map(&Enum.uniq(String.to_charlist(&1)))
        ~> Enum.frequencies()
        ~> Enum.find(fn {_, freq} -> freq == 3 end)
        ~> fn {char, _} -> value(char) end
      end)
    ~> Enum.sum
  end

end

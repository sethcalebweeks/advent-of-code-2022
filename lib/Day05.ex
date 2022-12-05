defmodule Day05 do
  use AOC

  @stacks %{
    "1" => ["W", "B", "G", "Z", "R", "D", "C", "V"],
    "2" => ["V", "T", "S", "B", "C", "F", "W", "G"],
    "3" => ["W", "N", "S", "B", "C"],
    "4" => ["P", "C", "V", "J", "N", "M", "G", "Q"],
    "5" => ["B", "H", "D", "F", "L", "S", "T"],
    "6" => ["N", "M", "W", "T", "V", "J"],
    "7" => ["G", "T", "S", "C", "L", "F", "P"],
    "8" => ["Z", "D", "B"],
    "9" => ["W", "Z", "N", "M"]
  }


  def move_by_1(stacks, %{"count" => 1, "from" => from, "to" => to}) do
    {item, new_from} = stacks[from] |> List.pop_at(0)
    stacks |> Map.merge(%{
      from => new_from,
      to => [item | stacks[to]]
    })
  end
  def move_by_1(stacks, %{"count" => count, "from" => from, "to" => to}) do
    {item, new_from} = stacks[from] |> List.pop_at(0)
    stacks
    |> Map.merge(%{
      from => new_from,
      to => [item | stacks[to]]
    })
    |> move_by_1(%{"count" => count - 1, "from" => from, "to" => to})
  end

  def move_by_count(stacks, %{"count" => count, "from" => from, "to" => to}) do
    {items, new_from} = stacks[from] |> Enum.split(count)
    stacks |> Map.merge(%{
      from => new_from,
      to => items ++ stacks[to]
    })
  end

  def parse_instructions(fun) do
    [_, instructions] = input(5) ~> String.split("\n\n")

    instructions
    |> String.split("\n")
    |> Enum.reduce(@stacks, fn instruction, stacks ->
      %{"count" => count, "from" => from, "to" => to} = Regex.named_captures(~r/move (?<count>.*) from (?<from>.*) to (?<to>.*)/, instruction)
      fun.(stacks,  %{"count" => String.to_integer(count), "from" => from, "to" => to})
    end)
    |> Enum.reduce("", fn {_, stack}, str -> str <> hd(stack) end)
  end

  def part1, do: parse_instructions(&move_by_1/2)

  def part2, do: parse_instructions(&move_by_count/2)

end

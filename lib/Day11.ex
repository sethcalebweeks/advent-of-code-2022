defmodule Day11 do
  use AOC

  def new("old", "+", "old"), do: fn old -> old + old end
  def new(left, "+", "old"), do: fn old -> String.to_integer(left) + old end
  def new("old", "+", right), do: fn old -> old + String.to_integer(right)  end
  def new("old", "*", "old"), do: fn old -> old * old end
  def new(left, "*", "old"), do: fn old -> String.to_integer(left)  * old end
  def new("old", "*", right), do: fn old -> old * String.to_integer(right)  end

  def parse_note(note) do
    info = Regex.named_captures(
~r/Monkey (?<monkey>\d):
  Starting items: (?<items>.*)
  Operation: new = (?<left>.*) (?<op>.*) (?<right>.*)
  Test: divisible by (?<test>.*)
    If true: throw to monkey (?<throw_true>.*)
    If false: throw to monkey (?<throw_false>.*)/, note)
    {String.to_integer(info["monkey"]), %{
      count: 0,
      items: info["items"] |> String.split(", ") |> Enum.map(&String.to_integer/1),
      operation: new(info["left"], info["op"], info["right"]),
      test: fn test -> if rem(test, info["test"] |> String.to_integer) == 0 do
          info["throw_true"] |> String.to_integer()
        else
          info["throw_false"] |> String.to_integer()
        end
      end
    }}
  end

  def notes() do
    input(11)
    |> String.split("\n\n", trim: true)
    |> Map.new(&parse_note/1)
  end


  def part1 do
    notes = notes()
    Enum.reduce(1..(20 * map_size(notes)), notes, fn i, monkeys ->
      current_monkey = rem(i - 1, map_size(notes))
      %{items: items, operation: operation, test: test} = monkeys[current_monkey]
      Enum.reduce(items, monkeys, fn item, state ->
        new_worry_level = operation.(item) |> div(3)
        state
        |> update_in([test.(new_worry_level), :items], fn items -> items ++ [new_worry_level] end)
        |> update_in([current_monkey, :items], fn [_ | items] -> items end)
        |> update_in([current_monkey, :count], fn count -> count + 1 end)
      end)
    end)
    |> Enum.sort_by(fn {_, %{count: count}} -> count end, :desc)
    |> Enum.take(2)
    |> Enum.reduce(fn {_, %{count: first_count}}, {_, %{count: second_count}} ->
      first_count * second_count
    end)
  end

  def part2 do
    notes = notes()
    Enum.reduce(1..(10_000 * map_size(notes)), notes, fn i, monkeys ->
      current_monkey = rem(i - 1, map_size(notes))
      %{items: items, operation: operation, test: test} = monkeys[current_monkey]
      Enum.reduce(items, monkeys, fn item, state ->
        new_worry_level = operation.(item) |> rem(9699690)
        state
        |> update_in([test.(new_worry_level), :items], fn items -> items ++ [new_worry_level] end)
        |> update_in([current_monkey, :items], fn [_ | items] -> items end)
        |> update_in([current_monkey, :count], fn count -> count + 1 end)
      end)
    end)
    |> Enum.sort_by(fn {_, %{count: count}} -> count end, :desc)
    |> Enum.take(2)
    |> Enum.reduce(fn {_, %{count: first_count}}, {_, %{count: second_count}} ->
      first_count * second_count
    end)
  end

end

defmodule Day10 do
  use AOC

  def execute("noop", {cycles, register}), do: {cycles ++ [register], register}
  def execute("addx " <> value, {cycles, register}) do
    updated_register = register + String.to_integer(value)
    {cycles ++ [register, updated_register], updated_register}
  end

  def part1 do
    input(10)
    |> String.split("\n", trim: true)
    |> Enum.reduce({[1], 1}, &execute/2)
    |> elem(0)
    |> (&Enum.slice(&1, 19..length(&1))).()
    |> Enum.take_every(40)
    |> Enum.zip(20..220//40)
    |> Enum.reduce(0, fn {register, cycle}, signal -> signal + register * cycle end)
  end

  def part2 do
    input(10)
    |> String.trim
    |> String.split("\n", trim: true)
    |> Enum.reduce({[1], 1}, &execute/2)
    |> elem(0)
    |> Enum.with_index
    |> Enum.map(fn
      {register, position} when register - rem(position, 40) in -1..1 -> "#"
      _ -> "."
    end)
    |> Enum.chunk_every(40)
    |> Enum.map(&Enum.join/1)
  end

end

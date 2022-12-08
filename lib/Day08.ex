defmodule Day08 do
  use AOC

  def get_grid() do
    input(8)
    |> String.trim
    |> String.split("\n")
    |> Enum.with_index
    |> Enum.reduce(%{}, fn {row, row_num}, map ->
      row
      |> String.trim
      |> String.codepoints
      |> Enum.with_index
      |> Map.new(fn {height, col_num} -> {{row_num, col_num}, String.to_integer(height)} end)
      |> Map.merge(map)
    end)
  end


  def part1 do
    grid = get_grid()
    grid
    |> Enum.map(fn {{row_num, col_num}, height} ->
      if (row_num == 0 || row_num == 98 || col_num == 0 || col_num == 98) do
        true
      else
        Enum.any?([
          (for col_num <- 0..(col_num-1), do: Map.get(grid, {row_num, col_num}) < height) |> Enum.all?,
          (for col_num <- (col_num+1)..98, do: Map.get(grid, {row_num, col_num}) < height) |> Enum.all?,
          (for row_num <- 0..(row_num-1), do: Map.get(grid, {row_num, col_num}) < height) |> Enum.all?,
          (for row_num <- (row_num+1)..98, do: Map.get(grid, {row_num, col_num}) < height) |> Enum.all?,
        ])
      end
    end)
    |> Enum.count(&Function.identity/1)
  end

  def part2 do
    grid = get_grid()
    grid
    |> Enum.map(fn {{row_num, col_num}, height} ->
      if (row_num == 0 || row_num == 98 || col_num == 0 || col_num == 98) do
        0
      else
        [
          (for col_num <- (col_num-1)..0, do: Map.get(grid, {row_num, col_num})),
          (for col_num <- (col_num+1)..98, do: Map.get(grid, {row_num, col_num})),
          (for row_num <- (row_num-1)..0, do: Map.get(grid, {row_num, col_num})),
          (for row_num <- (row_num+1)..98, do: Map.get(grid, {row_num, col_num})),
        ]
        |> Enum.reduce(1, fn direction, product ->
          visible = direction
          |> Enum.take_while(fn tree -> tree < height end)
          |> (fn blocked -> min(length(blocked) + 1, length(direction)) end).()
          (visible) * product
        end)
      end
    end)
    |> Enum.max
  end

end

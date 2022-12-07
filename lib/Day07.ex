defmodule Day07 do
  use AOC

  @node %{files: %{}, total_size: 0}

  def parse_filesystem() do
    input(7)
    |> String.trim
    |> String.split("\n")
    |> Enum.reduce({[], %{"/" => @node}}, &process_line/2)
    |> elem(1)
  end

  def process_line("$ ls", acc), do: acc
  def process_line("$ cd ..", {[_ | ancestors], fs}), do: {ancestors, fs}
  def process_line("$ cd " <> dir, {current_dir, fs}), do: {[dir | current_dir], fs}
  def process_line("dir " <> dir, {current_dir, fs}), do:
    {current_dir, put_in(fs, Enum.reverse([dir | current_dir]), @node)}
  def process_line(file, {current_dir, fs}) do
    [size, filename] = String.split(file)
    new_fs = update_total_size(fs, current_dir, String.to_integer(size))
    |> put_in(Enum.reverse([filename, :files | current_dir]), String.to_integer(size))
    {current_dir, new_fs}
  end


  def update_total_size(fs, [], _), do: fs
  def update_total_size(fs, [_ | ancestors] = path, file_size) do
    get_and_update_in(fs, Enum.reverse([:total_size | path]), fn total_size ->
      {total_size, total_size + file_size}
    end)
    |> (fn {_, fs} -> update_total_size(fs, ancestors, file_size) end).()
  end


  def total_size_under_100000(folder) do
    {total_size, without_size} = Map.pop(folder, :total_size, 0)
    {_, without_files} = Map.pop(without_size, :files)
    added_size = if(total_size <= 100000, do: total_size, else: 0)
    added_size + (Enum.map(without_files, fn {_, v} -> total_size_under_100000(v) end) |> Enum.sum)
  end

  def large_enough(folder, space_needed) do
    {total_size, without_size} = Map.pop(folder, :total_size, 0)
    {_, without_files} = Map.pop(without_size, :files)
    cond do
      total_size > space_needed -> [total_size | Enum.flat_map(without_files, fn {_, v} -> large_enough(v, space_needed) end)]
      true -> []
    end
  end

  def part1, do: parse_filesystem() |> (fn %{"/" => root} -> total_size_under_100000(root) end).()

  def part2 do
    %{"/" => %{total_size: used_space} = root} = parse_filesystem()
    space_needed = 30000000 - (70000000 - used_space)
    large_enough(root, space_needed) |> Enum.min()
  end

end

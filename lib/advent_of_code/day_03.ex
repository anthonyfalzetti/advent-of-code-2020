defmodule AdventOfCode.Day03 do
  def part1(_args) do
    parse_input()
    |> traverse_path()
    |> count_trees()
  end

  def part2(_args) do
  end

  defp parse_input() do
    "data/day_3_input"
    |> File.stream!()
    |> Enum.map(fn(row) ->
      row
      |> String.split("")
    end)
  end

  defp traverse_path(grid) do
    grid
    |> Enum.reduce({1, []}, fn(row, {starting_location, path}) ->
      current_location = starting_location + 3
      object = Enum.at(row, current_location)
      {current_location, [object|path]}
    end)
    |> elem(1)
  end

  defp count_trees(list_of_objects) do
    list_of_objects
    |> Enum.filter(fn(row) -> row == "#" end)
    |> Enum.count()
  end
end

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
      |> String.trim()
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> List.duplicate(50)
      |> List.flatten()
    end)
  end

  defp traverse_path(grid) do
    grid
    |> Enum.reduce({-3, []}, fn(row, {starting_location, path}) ->
      current_location = starting_location + 3
      object = Enum.at(row, current_location)
      |> IO.inspect(label: :object)

      {current_location, [object|path]}
    end)
    |> elem(1)
    |> IO.inspect(label: :objects)
  end

  defp count_trees(list_of_objects) do
    list_of_objects
    |> IO.inspect(label: :list_of_objects)
    |> Enum.filter(fn(row) -> row == "#" end)
    |> Enum.count()
  end
end

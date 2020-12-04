defmodule AdventOfCode.Day03 do
  def part1(_args) do
    [{3,1}]
    |> Enum.map(fn{right, down} ->
      parse_input()
      |> traverse_path(right, down)
      |> count_trees()
    end)
    |> Enum.sum()
  end

  def part2(_args) do
    [{1,1},{3,1},{5,1},{7,1},{1,2}]
    # [{3,1}]
    |> Enum.map(fn{right, down} ->
      parse_input()
      |> traverse_path(right, down)
      |> count_trees()
    end)
    |> Enum.reduce(1, fn(count, acc) ->
      count * acc
    end)
  end

  defp parse_input() do
    "data/day_3_input"
    |> File.stream!()
    |> Enum.map(fn(row) ->
      row
      |> String.trim()
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> List.duplicate(1000)
      |> List.flatten()
    end)
  end

  defp traverse_path(grid, right, 2) do
    [nil|grid]
    |> Enum.drop_every(2)
    |> traverse_path(right, 1)
  end

  defp traverse_path(grid, right, _down) do
    grid
    |> Enum.reduce({-right, []}, fn(row, {starting_location, path}) ->
      current_location = starting_location + right
      object = Enum.at(row, current_location)

      {current_location, [object|path]}
    end)
    |> elem(1)
  end

  defp count_trees(list_of_objects) do
    list_of_objects
    |> IO.inspect(label: :list_of_objects)
    |> Enum.filter(fn(row) -> row == "#" end)
    |> Enum.count()
  end
end

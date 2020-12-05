defmodule AdventOfCode.Day05 do
  def part1(_args) do
    parse_input()
    |> Enum.map(&(calucalte_seat_id(&1)))
    |> Enum.max()
  end

  def part2(_args) do
  end

  defp calucalte_seat_id({row_list, column_list}) do
    (calculate_row(row_list) * 8) +
      calculate_column(column_list)
  end

  defp calculate_row(row_list) do
    rows = (0..127)
    |> Enum.map(&(&1))
    row_list
    |> String.split("")
    |> Enum.reject(&(&1 == ""))
    |> Enum.reduce(rows, fn(bsp, acc) ->
      half_point = acc
      |> Enum.count()
      |> div(2)

      acc
      |> Enum.split(half_point)
      |> select(bsp)
    end)
    |> List.last()
    |> IO.inspect(label: :row)
  end

  defp calculate_column(row_list) do
    rows = (0..7)
    |> Enum.map(&(&1))
    row_list
    |> String.split("")
    |> Enum.reject(&(&1 == ""))
    |> Enum.reduce(rows, fn(bsp, acc) ->
      half_point = acc
      |> Enum.count()
      |> div(2)

      acc
      |> Enum.split(half_point)
      |> select(bsp)
    end)
    |> List.last()
    |> IO.inspect(label: :column)
  end

  defp select({lower, _upper}, "F"), do: lower
  defp select({_lower, upper}, "B"), do: upper
  defp select({lower, _upper}, "L"), do: lower
  defp select({_lower, upper}, "R"), do: upper

  defp parse_input() do
    "data/day_5_input"
    |> File.stream!()
    |> Enum.map(fn(row) ->
      row
      |> String.trim()
      |> String.split_at(7)
    end)
  end
end

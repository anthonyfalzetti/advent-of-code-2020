defmodule AdventOfCode.Day04 do
  def part1(_args) do
    parse_input()
    |> filter_rows()
    |> Enum.count()
  end

  def part2(_args) do
  end

  defp parse_input() do
    "data/day_4_input"
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(fn(row) ->
      row
      |> String.replace("\n", " ")
      |> String.split(" ")
      |> Enum.reduce(%{}, fn(kv_pairs, acc) ->
        [k, v] = String.split(kv_pairs, ":")
        Map.put(acc, k, v)
      end)
    end)
  end

  defp filter_rows(rows_list) do
    rows_list
    |> Enum.filter(&validate_row(&1))
  end


  defp validate_row(row) do
    ["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"]
    |> Enum.all?(fn(k) ->
      row
      |> Map.keys()
      |> Enum.member?(k)
    end)
  end
end

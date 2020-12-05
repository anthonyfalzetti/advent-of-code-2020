defmodule AdventOfCode.Day04 do
  def part1(_args) do
    parse_input()
    |> filter_rows()
    |> Enum.count()
  end

  def part2(_args) do
    parse_input()
    |> filter_rows()
    |> Enum.count()
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
    ["byr", "iyr", "eyr","hgt", "ecl", "hcl", "pid"]
    |> Enum.all?(fn(k) ->
      result = validate_value(k, row)
      IO.puts """
      k: #{k}
      row: #{inspect(row)}
      result: #{result}
      """
      result
    end)
  end

  defp validate_value("byr", %{"byr" => byr}) do
    {year, ""} = Integer.parse(byr)
    year >= 1920 && year <= 2002
  end
  defp validate_value("iyr", %{"iyr" => iyr}) do
    {year, ""} = Integer.parse(iyr)
    year >= 2010 && year <= 2020
  end
  defp validate_value("eyr", %{"eyr" => eyr}) do
    {year, ""} = Integer.parse(eyr)
    year >= 2020 && year <= 2030
  end
  defp validate_value("hgt", %{"hgt" => hgt}) do
    hgt
    |> String.split_at(-2)
    |> case do
      {inc, "in"} ->
        inches = inc
        |> Integer.parse()
        |> elem(0)

        inches >= 59 && inches <= 76
        {cm, "cm"} ->
          cent = cm
          |> Integer.parse()
          |> elem(0)

          cent >= 150 && cent <= 193
      _ -> false
    end
  end
  defp validate_value("ecl", %{"ecl" => ecl}) do
    ~w(amb blu brn gry grn hzl oth)
    |> Enum.any?(&(&1 == ecl))
  end
  defp validate_value("hcl", %{"hcl" => hcl}) do
    String.length(hcl) == 7 &&
    Regex.match?(~r/^#[0-9a-fA-F]{6,6}/, hcl)
  end
  defp validate_value("pid", %{"pid" => pid}) do
    String.length(pid) == 9 &&
    Regex.match?(~r/^[\d]{9,9}/, pid)
  end
  defp validate_value(_, _), do: false
end

defmodule AdventOfCode.Day02 do
  def part1(_args) do
    parse_input()
    |> Enum.filter(&(test_password(&1)))
    |> Enum.count()
  end

  def part2(_args) do
  end

  defp parse_input() do
    "data/day_2_input"
    |> File.stream!()
    |> Enum.map(fn(row) ->
      row
      |> String.split(":")
      |> parse_policy_and_password()
    end)
  end

  defp parse_policy_and_password([policy, password]) do
    {parse_policy(policy), parse_password(password)}
  end

  defp parse_policy(policy) do
    [range, letter] = policy
    |> String.split(" ")

    [min, max] = range
    |> String.split("-")
    |> Enum.map(fn(x) ->
      x
      |> Integer.parse()
      |> elem(0)
    end)

    {letter, {min, max}}
  end

  defp parse_password(password), do: String.trim(password)

  defp test_password({policy, password}) do
    count_letters(password)
    |> test_policy(policy)
  end

  defp count_letters(password) do
    password
    |> String.split("")
    |> Enum.frequencies()
  end

  defp test_policy(password_map, {letter, {min, max}}) do
    if Map.has_key?(password_map, letter) do
      occurrances = Map.get(password_map, letter)
      occurrances >= min && occurrances <= max
    else
      false
    end
  end
end

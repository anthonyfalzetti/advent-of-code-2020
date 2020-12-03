defmodule AdventOfCode.Day02 do
  def part1(_args) do
    {policies, passwords} = parse_input()

    IO.inspect(policies, label: :policies)
    {remaining_passwords, rejected_password} = passwords
    |> Enum.split_with(&(test_password(policies, &1)))

    require IEx; IEx.pry

    Enum.count(remaining_passwords)
    |> IO.inspect(label: :count)
  end

  def part2(_args) do
  end

  defp parse_input() do
    "data/day_2_input"
    |> File.stream!()
    |> Enum.reduce({%{},[]}, fn(row, {policies, passwords}) ->
      {{letter, {min, max}}, password} = row
      |> String.split(":")
      |> parse_policy_and_password()

      {
        Map.put(policies, letter, %{min: min, max: max}),
        [password|passwords]
      }
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

  defp test_password(policies, password) do
    password_map = count_letters(password)
    |> IO.inspect(label: :password_map)

    IO.puts """
    all_policies_fit: #{all_policies_fit(password_map, policies)}
    """

    all_policies_fit(password_map, policies)
  end

  defp count_letters(password) do
    password
    |> String.split("")
    |> Enum.frequencies()
  end

  # defp any_policies_fit(password_map, policies) do
  #   policies
  #   |> Enum.any?(fn({letter, _}) ->
  #     Enum.member?(Map.keys(password_map), letter)
  #   end)
  # end

  defp all_policies_fit(password_map, policies) do
    policies
    |> Enum.any?(fn({letter, %{min: min, max: max}}) ->
      test_policy(password_map, letter, min, max)
    end)
  end

  defp test_policy(password_map, letter, min, max) do
    if Map.has_key?(password_map, letter) do
      occurrances = Map.get(password_map, letter)
      occurrances >= min && occurrances <= max
    else
      false
    end
  end
end

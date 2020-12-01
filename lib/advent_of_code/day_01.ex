defmodule AdventOfCode.Day01 do
  def part1(_args) do
    list_of_integers = parse_integers()

    list_of_integers
    |> Enum.reduce_while(nil, fn(outter_integer, _acc) ->
      list_of_integers
      |> Enum.reduce_while(nil, fn(inner_integer, _acc) ->
        if outter_integer + inner_integer == 2020 do
          {:halt, {outter_integer, inner_integer}}
        else
          {:cont, nil}
        end
      end)
      |> case do
        {x, y} ->
          {:halt, x * y}
        nil ->
          {:cont, nil}
      end
    end)
    |> IO.inspect(label: :answer)
  end
  def part2(_args) do
    list_of_integers = parse_integers()

    list_of_integers
    |> Enum.reduce_while(nil, fn(outter_integer, _acc) ->
      list_of_integers
      |> iterate(outter_integer)
      |> case do
        {x, y, z} ->
          {:halt, x * y * z}
        nil ->
          {:cont, nil}
      end
    end)
    |> IO.inspect(label: :answer)
  end

  defp iterate(list_of_integers, outter_integer) do
    list_of_integers
    |> Enum.reduce_while(nil, fn(inner_integer, _acc) ->
      iterate(list_of_integers, outter_integer, inner_integer)
      |> case do
        {x, y, z} ->
          {:halt, {x, y, z}}
        nil ->
          {:cont, nil}
      end
    end)
  end

  defp iterate(list_of_integers, outter_integer, middle_integer) do
    list_of_integers
    |> Enum.reduce_while(nil, fn(inner_integer, _acc) ->
      if outter_integer + middle_integer + inner_integer == 2020 do
        {:halt, {outter_integer, middle_integer, inner_integer}}
      else
        {:cont, nil}
      end
    end)
  end

  defp parse_integers() do
    "data/day_1_input"
    |> File.stream!()
    |> Enum.map(fn(row) ->
      row
      |> String.trim()
      |> Integer.parse()
      |> elem(0)
    end)
  end
end

defmodule AOCDayOne do
  {:ok, inputs} = File.read("./inputs/day-1.txt")

  target_sum = 2020

  entry_list =
    inputs
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn x ->
      x
      |> String.trim()
      |> String.to_integer()
    end)

  matching =
    Enum.reduce(entry_list, nil, fn x, xacc ->
      if xacc == nil,
        do:
          Enum.reduce(entry_list, nil, fn y, yacc ->
            if yacc == nil,
              do:
                Enum.reduce(entry_list, nil, fn z, zacc ->
                  if x + y + z == target_sum, do: {x, y, z}, else: zacc
                end),
              else: yacc
          end),
        else: xacc
    end)

  {num1, num2, num3} = matching

  IO.inspect(num1 * num2 * num3)
end

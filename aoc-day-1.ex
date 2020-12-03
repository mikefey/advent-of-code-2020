defmodule AOCDayOne do
  {:ok, inputs} = File.read("./inputs/day-1.txt") 

  target_sum = 2020

  entry_list =
    inputs
    |> String.trim()
    |> String.split("\n")

  formatted_entry_list =
    entry_list
    |> Enum.map(fn x ->
      x
      |> String.trim()
      |> String.to_integer()
    end)

  def equals_target(num, num2, target) do
    num + num2 == target
  end

  matching =
    Enum.reduce(formatted_entry_list, nil, fn x, xacc ->
      if xacc == nil,
        do:
          Enum.reduce(formatted_entry_list, nil, fn y, yacc ->
            if yacc == nil,
              do:
                Enum.reduce(formatted_entry_list, nil, fn z, zacc ->
                  if x + y + z == target_sum, do: {x, y, z}, else: zacc
                end),
              else: yacc
          end),
        else: xacc
    end)

  {num1, num2, num3} = matching

  IO.inspect(num1 * num2 * num3)
end

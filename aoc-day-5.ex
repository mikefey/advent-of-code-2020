defmodule AOCDayFive do
  {:ok, inputs} = File.read("./inputs/day-5.txt")

  max_rows = 127
  max_columns = 7

  ids =
    inputs
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn(row) ->
      positions =
        row
        |> String.split("")
        |> Enum.reject(fn x -> x == "" end)

      row_positions = Enum.take(positions, 7)
      column_positions = Enum.take(positions, -3)

      row_position = Enum.reduce(row_positions, Enum.to_list(0..max_rows), fn(pos, acc) ->
        {lower, upper} = Enum.split(acc, div(Enum.count(acc), 2))
        if pos == "F", do: lower, else: upper
      end)

      column_position = Enum.reduce(column_positions, Enum.to_list(0..max_columns), fn(pos, acc) ->
        {lower, upper} = Enum.split(acc, div(Enum.count(acc), 2))
        if pos == "L", do: lower, else: upper
      end)

      [final_row] = row_position
      [final_column] = column_position
      (final_row * 8) + final_column
    end)

  sorted_ids = Enum.sort(ids, &(&1 >= &2))
  IO.inspect Enum.at((Enum.to_list(976..0) -- sorted_ids), 0)
end
defmodule AOCDayThree do
  {:ok, inputs} = File.read("./inputs/day-3.txt")

  rows =
    inputs
    |> String.trim()
    |> String.split("\n")

  increments = [
    %{x: 1, y: 1},
    %{x: 3, y: 1},
    %{x: 5, y: 1},
    %{x: 7, y: 1},
    %{x: 1, y: 2}
  ]

  # because we will be multiplying, start with 1 instead of 0,
  # so the first pass doesn't equal 0
  @totals %{tree: 1, clear: 1}

  Enum.each(increments, fn increment ->
    @current_position %{x: 0, y: 0}
    @char_count %{tree: 0, clear: 0}

    Enum.each(0..Enum.count(rows), fn _row ->
      %{x: init_x, y: init_y} = @current_position

      @current_position %{
        @current_position
        | x: init_x + Map.get(increment, :x),
          y: init_y + Map.get(increment, :y)
      }
      %{x: new_x, y: new_y} = @current_position

      if new_y < Enum.count(rows) do
        new_x_adjusted =
          if new_x < String.length(Enum.at(rows, new_y)),
            do: new_x,
            else: rem(new_x, String.length(Enum.at(rows, new_y)))

        @char_count if String.at(Enum.at(rows, new_y), new_x_adjusted) == "#",
                      do: %{@char_count | tree: Map.get(@char_count, :tree) + 1},
                      else: %{@char_count | clear: Map.get(@char_count, :clear) + 1}
      end
    end)

    @totals %{
      @totals
      | tree: Map.get(@totals, :tree) * Map.get(@char_count, :tree),
        clear: Map.get(@totals, :clear) + Map.get(@char_count, :clear)
    }
  end)

  IO.inspect(@totals)
end

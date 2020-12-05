defmodule AOCDayTwo do
  {:ok, inputs} = File.read("./inputs/day-2.txt")

  valid_counts =
    inputs
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn x ->
      x
      |> String.trim()
    end)
    |> Enum.reduce(%{:valid => 0, :invalid => 0}, fn x, acc ->
      split = String.split(x, ":")
      rule = String.trim(Enum.at(split, 0))
      split_rule = String.split(rule, " ")
      occurence_rule = Enum.at(split_rule, 0)
      target_letter = Enum.at(split_rule, 1)
      split_occurence_rule = String.split(occurence_rule, "-")
      first_occurence = String.to_integer(Enum.at(split_occurence_rule, 0))
      second_occurence = String.to_integer(Enum.at(split_occurence_rule, 1))
      target_letter = Enum.at(split_rule, 1)
      password = String.trim(Enum.at(split, 1))

      if (String.at(password, first_occurence - 1) !== target_letter &&
            String.at(password, second_occurence - 1) !== target_letter) ||
           (String.at(password, first_occurence - 1) == target_letter &&
              String.at(password, second_occurence - 1) == target_letter),
         do: %{:valid => Map.fetch!(acc, :valid), :invalid => Map.fetch!(acc, :invalid) + 1},
         else: %{:valid => Map.fetch!(acc, :valid) + 1, :invalid => Map.fetch!(acc, :invalid)}
    end)

  IO.inspect(valid_counts)
end

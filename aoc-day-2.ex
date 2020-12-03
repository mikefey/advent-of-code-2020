defmodule AOCDayTwo do
  {:ok, inputs} = File.read("./inputs/day-2.txt") 

  input_list =
    inputs
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn x ->
      x
      |> String.trim()
    end)

  valid_counts =
    Enum.reduce(input_list, %{:valid => 0, :invalid => 0}, fn x, acc ->
      split = String.split(x, ":")
      rule = String.trim(Enum.at(split, 0))
      split_rule = String.split(rule, " ")
      occurence_rule = Enum.at(split_rule, 0)
      target_letter = Enum.at(split_rule, 1)
      split_occurence_rule = String.split(occurence_rule, "-")
      # min_occurence = String.to_integer(Enum.at(split_occurence_rule, 0))
      # max_occurence = String.to_integer(Enum.at(split_occurence_rule, 1))
      first_occurence = String.to_integer(Enum.at(split_occurence_rule, 0))
      second_occurence = String.to_integer(Enum.at(split_occurence_rule, 1))
      target_letter = Enum.at(split_rule, 1)
      password = String.trim(Enum.at(split, 1))

      # occurences_of_target = String.length(password) - String.length(List.to_string(String.split(password, target_letter)))

      # if occurences_of_target < min_occurence || occurences_of_target > max_occurence,
      #   do: %{:valid => Map.fetch!(acc, :valid), :invalid => Map.fetch!(acc, :invalid) + 1},
      #   else: %{:valid => Map.fetch!(acc, :valid) + 1, :invalid => Map.fetch!(acc, :invalid)}

      if (String.at(password, first_occurence - 1) !== target_letter &&
            String.at(password, second_occurence - 1) !== target_letter) ||
           (String.at(password, first_occurence - 1) == target_letter &&
              String.at(password, second_occurence - 1) == target_letter),
         do: %{:valid => Map.fetch!(acc, :valid), :invalid => Map.fetch!(acc, :invalid) + 1},
         else: %{:valid => Map.fetch!(acc, :valid) + 1, :invalid => Map.fetch!(acc, :invalid)}
    end)

  IO.inspect(valid_counts)
end

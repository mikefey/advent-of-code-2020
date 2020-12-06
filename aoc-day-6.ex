defmodule AOCDaySix do
  {:ok, inputs} = File.read("./inputs/day-6.txt")

  counts =
    inputs
    |> String.split("\n")
    |> Enum.chunk_by(fn row ->
      row == ""
    end)
    |> Enum.map(fn line ->
      Enum.map(line, fn item ->
        String.split(item)
      end)
    end)
    |> Enum.map(fn lines ->
      Enum.reduce(lines, [], fn items, acc ->
        acc ++ items
      end)
    end)
    |> Enum.reject(fn row ->
      row == []
    end)
    |> Enum.map(fn answers ->
      reference = Enum.at(answers, 0)

      if Enum.count(answers) === 1 do
        String.length(reference)
      else
        rest = Enum.take(answers, (Enum.count(answers) - 1) * -1)

        reference_list =
          String.split(reference, "")
          |> Enum.reject(fn char -> char == "" end)

        answers_contain_char = Enum.reduce(reference_list, 0, fn char, acc ->
          matches = Enum.reduce(rest, 0, fn (answer, contains) ->
            if String.contains?(answer, char), do: contains + 1, else: contains
          end)

          if matches == Enum.count(rest), do: acc + 1, else: acc
        end)
        
        answers_contain_char
      end
    end)
    |> Enum.reduce(0, fn (count, total) ->
      total + count
    end)



  IO.inspect counts
end

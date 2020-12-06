defmodule AOCDaySix do
  {:ok, inputs} = File.read("./inputs/day-6.txt")

  counts =
    inputs
    |> String.split("\n")
    |> Enum.chunk_by(fn row ->
      row == ""
    end)
    |> Enum.reject(fn row ->
      row == [""]
    end)
    |> Enum.map(fn line ->
      Enum.map(line, fn item ->
        String.split(item, " ")
      end)
    end)
    |> Enum.map(fn lines ->
      Enum.reduce(lines, [], fn items, acc ->
        acc ++ items
      end)
    end)
    |> Enum.map(fn answers ->
      Enum.reduce(answers, "", fn answer, acc ->
        "#{acc}#{answer}"
      end)
    end)
    |> Enum.map(fn answers ->
      String.split(answers, "")
      |> Enum.reject(fn item ->
        item == ""
      end)
      |> Enum.uniq
    end) 
    |> Enum.map(fn answers ->
      Enum.reduce(answers, "", fn answer, acc ->
        "#{acc}#{answer}"
      end)
    end)
    |> Enum.map(fn answers ->
      String.length(answers)
    end)
    |> Enum.reduce(0, fn count, acc ->
      acc + count
    end)


  IO.inspect counts
end

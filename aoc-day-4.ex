defmodule AOCDayFour do
  {:ok, inputs} = File.read("./inputs/day-4.txt")

  required_keys = [
    :byr,
    :iyr,
    :eyr,
    :hgt,
    :hcl,
    :ecl,
    :pid
  ]

  data_hashes =
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
    |> Enum.map(fn line ->
      Enum.reduce(line, %{}, fn item, acc ->
        split_at_colon = String.split(item, ":")
        Map.put(acc, String.to_atom(Enum.at(split_at_colon, 0)), Enum.at(split_at_colon, 1))
      end)
    end)

  valid =
    Enum.reduce(data_hashes, %{valid: 0, invalid: 0}, fn hash, acc ->
      has_required_fields = required_keys |> Enum.all?(&Map.has_key?(hash, &1))

      valid_birth_year =
        Map.has_key?(hash, :byr) && String.to_integer(Map.get(hash, :byr)) >= 1920 &&
          String.to_integer(Map.get(hash, :byr)) <= 2002

      valid_issue_year =
        Map.has_key?(hash, :iyr) && String.to_integer(Map.get(hash, :iyr)) >= 2010 &&
          String.to_integer(Map.get(hash, :iyr)) <= 2020

      valid_expiration_year =
        Map.has_key?(hash, :eyr) && String.to_integer(Map.get(hash, :eyr)) >= 2020 &&
          String.to_integer(Map.get(hash, :eyr)) <= 2030

      height_contains_unit =
        Map.has_key?(hash, :hgt) && Regex.match?(~r/\d+(cm|in)/, Map.get(hash, :hgt))

      valid_height =
        height_contains_unit &&
          cond do
            Map.get(hash, :hgt) =~ "cm" ->
              height_int = String.to_integer(Enum.at(String.split(Map.get(hash, :hgt), "cm"), 0))
              height_int >= 150 && height_int <= 193

            Map.get(hash, :hgt) =~ "in" ->
              height_int = String.to_integer(Enum.at(String.split(Map.get(hash, :hgt), "in"), 0))
              height_int >= 59 && height_int <= 76

            true ->
              false
          end

      valid_hair_color =
        Map.has_key?(hash, :hcl) && Regex.match?(~r/[#]+([0-9]|[a-f]){6}/, Map.get(hash, :hcl))

      valid_eye_color =
        Map.has_key?(hash, :ecl) &&
          Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], Map.get(hash, :ecl))

      valid_passport =
        Map.has_key?(hash, :pid) && Regex.match?(~r/^\d{9}$/, Map.get(hash, :pid))

      if has_required_fields && valid_birth_year && valid_issue_year && valid_expiration_year &&
           valid_height && valid_hair_color && valid_eye_color && valid_passport,
         do: %{acc | valid: Map.get(acc, :valid) + 1},
         else: %{acc | invalid: Map.get(acc, :invalid) + 1}
    end)

  IO.inspect(valid)
end

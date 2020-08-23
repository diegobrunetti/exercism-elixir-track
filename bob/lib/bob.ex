defmodule Bob do
  alias String, as: S

  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      question?(input) and shouting?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      :default -> "Whatever."
    end
  end

  defp silence?(input), do: S.trim(input) == ""
  defp shouting?(input), do: S.upcase(input) == input and input != S.downcase(input)
  defp question?(input), do: S.trim(input) |> S.ends_with?("?")
end

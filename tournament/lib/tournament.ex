defmodule Tournament do
  @match %{team: "", mp: 1, w: 0, l: 0, d: 0, p: 0}
  @header String.pad_trailing("Team", 31, " ") <> "| MP |  W |  D |  L |  P"

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.map(&compute_match/1)
    |> Enum.reduce(%{}, &calc_tournament_results/2)
    |> Map.values()
    |> Enum.sort_by(& &1.p, :desc)
    |> print()
  end

  defp compute_match([team_a, team_b, "win"]) do
    %{
      team_a => %{@match | team: team_a, w: 1, p: 3},
      team_b => %{@match | team: team_b, l: 1}
    }
  end

  defp compute_match([team_a, team_b, "draw"]) do
    %{
      team_a => %{@match | team: team_a, d: 1, p: 1},
      team_b => %{@match | team: team_b, d: 1, p: 1}
    }
  end

  defp compute_match([team_a, team_b, "loss"]) do
    %{
      team_a => %{@match | team: team_a, l: 1},
      team_b => %{@match | team: team_b, w: 1, p: 3}
    }
  end

  defp compute_match(_invalid_input), do: %{}

  defp calc_tournament_results(match, acc), do: Map.merge(match, acc, &update_team_result/3)

  defp update_team_result(team, match_a, match_b) do
    %{
      team: team,
      mp: match_a.mp + match_b.mp,
      w: match_a.w + match_b.w,
      l: match_a.l + match_b.l,
      d: match_a.d + match_b.d,
      p: match_a.p + match_b.p
    }
  end

  defp print(results), do: @header <> "\n" <> rows(results)

  defp rows(results), do: results |> Enum.map_join("\n", &print_score/1)

  defp print_score(s) do
    ~s(#{String.pad_trailing(s.team, 30)} |  #{s.mp} |  #{s.w} |  #{s.d} |  #{s.l} |  #{s.p})
  end
end

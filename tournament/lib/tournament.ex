defmodule Tournament do
  @match %{mp: 1, wins: 0, losses: 0, draws: 0, points: 0}
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
    |> Enum.map_reduce(%{}, &calculate_results/2)
    |> Enum.sort(fn {team, results} -> )
    |> print()
  end

  defp calculate_results(match, acc) do
    match = eval_match(match)
    {match, Map.merge(match, acc, &update_team_results/3)}
  end

  defp eval_match([team_a, team_b, "win"]) do
    %{
      team_a => %{@match | wins: 1, points: 3},
      team_b => %{@match | losses: 1}
    }
  end

  defp eval_match([team_a, team_b, "draw"]) do
    %{
      team_a => %{@match | draws: 1, points: 1},
      team_b => %{@match | draws: 1, points: 1}
    }
  end

  defp eval_match([team_a, team_b, "loss"]) do
    %{
      team_a => %{@match | losses: 1},
      team_b => %{@match | wins: 1, points: 3}
    }
  end

  defp update_team_results(_team, match_a, match_b) do
    %{
      mp: match_a.mp + match_b.mp,
      wins: match_a.wins + match_b.wins,
      losses: match_a.losses + match_b.losses,
      draws: match_a.draws + match_b.draws,
      points: match_a.points + match_b.points
    }
  end

  defp print({_, results}) do
    """
    #{@header}
    #{rows(results)}
    """
  end

  defp rows(results) do
    results
    |> Enum.map(fn {team, r} -> print_score([team, r.mp, r.wins, r.draws, r.losses, r.points]) end)
    |> Enum.join("\n")
  end

  defp print_score([team, mp, w, d, l, p]) do
    String.pad_trailing(team, 30) <> " |  #{mp} |  #{w} |  #{d} |  #{l} |  #{p}"
  end
end

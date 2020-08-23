defmodule ProteinTranslation do
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    codons = for <<codon::binary-3 <- rna>>, do: codon

    codons
    |> Enum.map(&of_codon/1)
    |> Enum.reduce_while({:ok, []}, &group_proteins/2)
  end

  defp group_proteins(protein, {_, proteins}) do
    case protein do
      {:ok, "STOP"} -> {:halt, {:ok, proteins}}
      {:ok, protein} -> {:cont, {:ok, proteins ++ [protein]}}
      {:error, _} -> {:halt, {:error, "invalid RNA"}}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU: Cysteine
  UGC: Cysteine
  UUA: Leucine
  UUG: Leucine
  AUG: Methionine
  UUU: Phenylalanine
  UUC: Phenylalanine
  UCU: Serine
  UCC: Serine
  UCA: Serine
  UCG: Serine
  UGG: Tryptophan
  UAU: Tyrosine
  UAC: Tyrosine
  UAA: STOP
  UAG: STOP
  UGA: STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@proteins, codon) do
      {:ok, protein} -> {:ok, protein}
      _ -> {:error, "invalid codon"}
    end
  end
end

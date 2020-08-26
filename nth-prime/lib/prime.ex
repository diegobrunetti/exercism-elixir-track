defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1), do: 2
  def nth(2), do: 3

  def nth(n) when n > 2 do
    next_prime(5, [3], n)
  end

  defp next_prime(_number, primes_so_far, nth) when length(primes_so_far) == nth - 1 do
    hd(primes_so_far)
  end

  # Iterate through only odd values, incrementing by 2.
  # Divide each value by 2 < 𝑑𝑖𝑣𝑖𝑠𝑜𝑟 < sqrt(𝑣𝑎𝑙𝑢e), where 𝑑𝑖𝑣𝑖𝑠𝑜𝑟 is only any one of the primes
  # computed thus far. Any further optimization to be had, or should I resort to a sieve?
  # If the latter, then which one?
  defp next_prime(number, primes_so_far, nth) do
    is_prime =
      for(divisor <- primes_so_far, do: rem(number, divisor))
      |> Enum.filter(&(&1 == 0))
      |> Enum.empty?()

    if(is_prime) do
      next_prime(number + 2, [number | primes_so_far], nth)
    else
      next_prime(number + 2, primes_so_far, nth)
    end
  end
end

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
    List.last(primes_so_far)
  end

  # Iterate through only odd values, incrementing by 2.
  # Divide each value by 2 < 𝑑𝑖𝑣𝑖𝑠𝑜𝑟 < sqrt(𝑣𝑎𝑙𝑢e), where 𝑑𝑖𝑣𝑖𝑠𝑜𝑟 is only any one of the primes
  defp next_prime(number, primes_so_far, nth) do
    is_prime = Enum.all?(primes_so_far, fn n -> rem(number, n) != 0 end)

    if(is_prime) do
      next_prime(number + 2, primes_so_far ++ [number], nth)
    else
      next_prime(number + 2, primes_so_far, nth)
    end
  end
end

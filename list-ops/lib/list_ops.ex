defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_hd | tl]), do: 1 + count(tl)

  @spec reverse(list) :: list
  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([], acc), do: acc

  defp do_reverse([hd | tl], acc) do
    do_reverse(tl, [hd | acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(list, f) do
    for elem <- list, do: f.(elem)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, f) do
    for elem <- list, f.(elem), do: elem
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc

  def reduce([hd | tl], acc, f) do
    reduce(tl, f.(hd, acc), f)
  end

  @spec append(list, list) :: list
  def append([], b), do: b
  def append(a, []), do: a
  def append(a, b), do: concat([a, b])

  @spec concat([[any]]) :: [any]
  def concat([]), do: []

  def concat(ll) do
    ll
    |> reduce([], &do_reverse/2)
    |> reverse()
  end

  defp do_concat([], acc), do: acc

  defp do_concat([hd | tl], acc) do
    do_concat(tl, [hd | acc])
  end
end

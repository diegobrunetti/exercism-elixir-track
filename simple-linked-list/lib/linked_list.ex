defmodule LinkedList do
  import Kernel, except: [length: 1]
  @opaque t :: tuple()
  @empty_slot {}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: @empty_slot

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(@empty_slot, elem), do: {elem, @empty_slot}
  def push(list, elem), do: {elem, list}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length({_head, tail}), do: 1 + length(tail)
  def length(_any), do: 0

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({_head, _tail}), do: false
  def empty?(_empty), do: true

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({head, _tail}), do: {:ok, head}
  def peek(_empty), do: {:error, :empty_list}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({_head, tail}), do: {:ok, tail}
  def tail(_empty), do: {:error, :empty_list}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(@empty_slot), do: {:error, :empty_list}
  def pop({head, tail}), do: {:ok, head, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(new(), &push(&2, &1))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(@empty_slot), do: []
  def to_list(list), do: to_reverse_std_list(list, []) |> Enum.reverse()

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list
    |> to_reverse_std_list([])
    |> from_list()
  end

  defp to_reverse_std_list(@empty_slot, acc), do: acc
  defp to_reverse_std_list({head, tail}, acc), do: to_reverse_std_list(tail, [head | acc])
end

defmodule BinarySearchTree do
  @type bst_node :: %{data: integer(), left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(integer()) :: bst_node()
  def new(data) do
    %{data: data, right: nil, left: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node(), integer()) :: bst_node()
  def insert(nil, new_data) do
    new(new_data)
  end

  def insert(%{data: data} = tree, new_data) when new_data <= data do
    %{tree | left: insert(tree.left, new_data)}
  end

  def insert(%{data: data} = tree, new_data) when new_data > data do
    %{tree | right: insert(tree.right, new_data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node()) :: [integer()]
  def in_order(nil), do: []

  def in_order(tree) do
    in_order(tree.left) ++ [tree.data] ++ in_order(tree.right)
  end
end

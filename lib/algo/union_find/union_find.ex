defmodule Algo.UnionFind.UnionFind do
  use Agent

  @tree_pid :tree
  @size_tree_pid :size_tree

  def tree_pid, do: @tree_pid
  def size_tree_pid, do: @size_tree_pid

  def create(array_length) when is_integer(array_length) do
    with initial_tree <-
           Enum.reduce(0..array_length, %{}, fn item, acc -> Map.put(acc, item, item) end),
         initial_size_tree <-
           Enum.reduce(0..array_length, %{}, fn item, acc -> Map.put(acc, item, 1) end),
         {:ok, tree_pid} <- Agent.start(fn -> initial_tree end, name: @tree_pid),
         {:ok, size_tree_pid} <- Agent.start(fn -> initial_size_tree end, name: @size_tree_pid) do
      {:ok, %{tree_pid: tree_pid, size_tree_pid: size_tree_pid}}
    else
      error -> {:error, error}
    end
  end

  def update(new_value, pid) do
    Agent.update(pid, fn _ -> new_value end, 5000)
  end

  def get(pid) do
    Agent.get(pid, & &1)
  end

  def root(tree, int) do
    if tree[int] == int, do: int, else: root(tree, tree[int])
  end

  @spec connected?(tree :: list(), p :: integer, q :: integer) :: boolean
  def connected?(tree, p, q), do: root(tree, p) == root(tree, q)

  def union(tree, p, q) do
    first_root = root(tree, p)
    second_root = root(tree, q)

    size_tree = get(size_tree_pid())

    if first_root != second_root do
      if size_tree[first_root] < size_tree[second_root] do
        tree
        |> Map.replace(first_root, second_root)
        |> update(tree_pid())

        size_tree
        |> Map.replace(second_root, size_tree[second_root] + size_tree[first_root])
        |> update(size_tree_pid())
      else
        tree
        |> Map.replace(second_root, first_root)
        |> update(tree_pid())

        size_tree
        |> Map.replace(first_root, size_tree[first_root] + size_tree[second_root])
        |> update(size_tree_pid())
      end
    end
  end
end

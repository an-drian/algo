defmodule Algo.UnionFind.QuickFind do
  use Agent

  def create(array_length) when is_integer(array_length) do
    init_value = Enum.reduce(0..array_length, %{}, fn item, acc -> Map.put(acc, item, item) end)
    Agent.start(fn -> init_value end, name: __MODULE__)
  end

  def update(new_value) do
    Agent.update(__MODULE__, fn _ -> new_value end, 5000)
  end

  def get() do
    Agent.get(__MODULE__, & &1)
  end

  def connected?(state, p, q), do: state[p] == state[q]

  def union(p, q) do
    state = get()
    connection_to = state[q]

    state
    |> Map.new(fn {key, value} ->
      if value == p do
        {key, connection_to}
      else
        {key, value}
      end
    end)
    |> update()
  end
end

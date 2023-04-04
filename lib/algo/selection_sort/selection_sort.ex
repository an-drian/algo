defmodule Algo.SelectionSort.SelectionSort do
  def sort(list) when is_list(list) do
    select(list, [])
  end

  def select([head | []], acc), do: [head | acc] |> Enum.reverse()
  def select(list, acc) do
    min = find_min(list)

    list
    |> List.delete(min)
    |> select([min | acc])
  end

  def find_min([head | [second | []]]) do
    less(head, second)
  end

  def find_min([head | [second | tail]]) do
    find_min([less(head, second) | tail])
  end

  def less(v1, v2) do
    if v1 < v2, do: v1, else: v2
  end
end

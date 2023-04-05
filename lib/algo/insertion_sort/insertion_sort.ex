defmodule Algo.InsertionSort.InsertionSort do
  def sort(list) do
    do_sorting([], list)
  end

  defp do_sorting(sorted_list, []), do: sorted_list

  defp do_sorting(_sorted_list = [], [head | tail]) do
    do_sorting([head], tail)
  end

  defp do_sorting(sorted_list, [unsorted_head | unsorted_tail]) do
    insert(unsorted_head, sorted_list) |> do_sorting(unsorted_tail)
  end

  defp insert(element, []), do: [element]
  defp insert(element, [sorted_min | sorted_tail]) do
    if more_or_equal?(sorted_min, element),
      do: [element | [sorted_min | sorted_tail]],
      else: [sorted_min | insert(element, sorted_tail)]
  end

  defp more_or_equal?(v1, v2), do: v1 >= v2
end

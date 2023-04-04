defmodule Algo.Ds.Queue do
  def new, do: :queue.new()

  def enqueue(queue, item), do: :queue.in(item, queue)



  def dequeue({[], []}), do: {:empty, new()}
  def dequeue(queue) do
    {{:value, val}, updated_queue} = :queue.out(queue)
    {val, updated_queue}
  end

  def empty?({[], []}), do: true
  def empty?(_queue), do: false
end

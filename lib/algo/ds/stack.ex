defmodule Algo.Ds.Stack do
  @type val :: any()

  @type t :: %Algo.Ds.Stack{ array: [val] }
  defstruct array: []

  @spec new() :: t()
  def new() do
    %Algo.Ds.Stack{ array: [] }
  end

  @spec push(t(), val()) :: t()
  def push(%Algo.Ds.Stack{array: array}, new_item) do
    %Algo.Ds.Stack{array: [new_item | array]}
  end

  @spec pop(t()) :: {val(), t()}
  def pop(%Algo.Ds.Stack{array: [head | tail]}) do
    {head, %Algo.Ds.Stack{array: tail}}
  end

  def pop(%Algo.Ds.Stack{array: []}) do
    {nil, %Algo.Ds.Stack{array: []}}
  end

  @spec size(t()) :: integer()
  def size(%Algo.Ds.Stack{array: array}) do
    Enum.count(array)
  end
end

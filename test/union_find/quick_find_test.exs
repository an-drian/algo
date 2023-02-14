defmodule Algo.UnionFind.QuickFindTest do
  use ExUnit.Case
  alias Algo.UnionFind.QuickFind, as: QF

  test "create and get tree" do
    assert {:ok, pid} = QF.create(9)
    assert is_pid(pid)
    assert 10 = QF.get() |> Enum.count()
  end
end

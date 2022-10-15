defmodule Ra.Internal.Bag.Pair do
  @moduledoc false

  def fst({x, _}), do: x
  def snd({_, y}), do: y
end

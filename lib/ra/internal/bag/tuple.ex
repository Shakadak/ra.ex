defmodule Ra.Internal.Bag.Tuple do
  @moduledoc false

  def fst({x, _}), do: x
  def snd({_, y}), do: y
end

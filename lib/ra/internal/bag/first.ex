defmodule Ra.Internal.Bag.First do
  @moduledoc false
  import PatternMetonyms

  pattern first(a) = {:First, a}
end

defmodule Ra.Semigroup.First do
  import Ra.Internal.Bag.First
  import Ra.Internal.Bag.Maybe

  def append(first(just(_)) = first, _), do: first
  def append(_, second), do: second
end

defmodule Ra.Monoid.First do
  import Ra.Internal.Bag.First
  import Ra.Internal.Bag.Maybe

  def mempty, do: first(nothing())
end

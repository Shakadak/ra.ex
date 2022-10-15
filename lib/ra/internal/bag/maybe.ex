defmodule Ra.Internal.Bag.Maybe do
  @moduledoc false
  import PatternMetonyms

  pattern just(a) = {:Just, a}
  pattern nothing() = :Nothing

  def maybe(_, ab, just(a)), do: ab.(a)
  def maybe(b, _, nothing()), do: b
end

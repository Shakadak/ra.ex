defmodule Ra.Profunctor.Strong do
  alias Ra.Internal.Class
  require Class

  @doc "first : p a b -> p {a, c} {b, c}"
  Class.mk :first, 1
  @doc "second : p a b -> p {c, a} {c, b}"
  Class.mk :second, 1
end

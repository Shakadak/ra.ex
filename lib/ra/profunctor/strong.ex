defmodule Ra.Profunctor.Strong do
  alias Ra.Internal.Meta.Class
  require Class

  @doc "first : p a b -> p {a, c} {b, c}"
  Class.mk :first, 1
  @doc "second : p a b -> p {c, a} {c, b}"
  Class.mk :second, 1
end

defmodule Ra.Profunctor.Strong.Function do
  @moduledoc false

  def first(a2c), do: fn {a, b} -> {a2c.(a), b} end
  def second(b2c), do: fn {a, b} -> {a, b2c.(b)} end
end

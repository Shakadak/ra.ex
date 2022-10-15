defmodule Ra.Profunctor do
  #@moduledoc """
  #> #### Internal use only {: .warning}
  #>
  #> May be later moved outside this library, please do not rely on it.
  #"""

  alias Ra.Internal.Meta.Class
  require Class

  @doc "dimap : (a' -> a) -> (b -> b') -> p a b -> p a' b'"
  Class.mk :dimap, 3

  @doc """
  Map a function over the (covariant) second type argument only.
      rmap :: forall a b c p. Profunctor p => (b -> c) -> p a b -> p a c
  """
  def rmap(b2c, pab, profunctor) do
    import Ra.Internal.Bag.Function, only: [id: 1]
    dimap(&id/1, b2c, pab, profunctor)
  end
end

defmodule Ra.Profunctor.Function do
  @moduledoc false

  def dimap(f, g, h) do
    fn x -> g.(h.(f.(x))) end
  end
end

#defmodule Monoidal.Function do
#  def par(f, g), do: &Bag.cross(f, g, &1)
#  def empty, do: &Bag.id/1
#end

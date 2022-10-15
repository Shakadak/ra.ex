defmodule Ra.Iso do

  import Ra.Internal.Bag.Function, only: [id: 1]
  import Ra.Profunctor, only: [dimap: 4]

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()

  @doc """
  Create an Iso from a pair of morphisms.
      iso :: forall s t a b. (s -> a) -> (b -> t) -> Iso s t a b
  """
  def iso(sa, bt) do
    fn profunctor -> fn pab -> dimap(sa, bt, pab, profunctor) end end
  end

  @doc """
  Extracts the pair of morphisms from an isomorphism.
      withIso :: forall s t a b r. AnIso s t a b -> ((s -> a) -> (b -> t) -> r) -> r
  """
  def withIso(o, f) do
    use Ra.Types
    case o.(Exchange).(exchange(&id/1, &id/1)) do
      exchange(g, h) -> f.(g, h)
    end
  end
end

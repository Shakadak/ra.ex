defmodule Ra.Internal.Forget do
  @moduledoc false
  import PatternMetonyms

  @doc """
  Profunctor that forgets the `b` value and returns (and accumulates) a
  value of type `r`.
  
  `Forget r` is isomorphic to `Star (Const r)`, but can be given a `Cochoice`
  instance.

      newtype Forget :: forall k. Type -> Type -> k -> Type
      newtype Forget r a b = Forget (a -> r)
  """
  pattern forget(f) = {:Forget, f}
end

defmodule Ra.Profunctor.Forget do
  @moduledoc false
  import Ra.Internal.Forget, only: [forget: 1]
  def dimap(f, _, forget(z)), do: forget(&z.(f.(&1)))
end

defmodule Ra.Profunctor.Strong.Forget do
  @moduledoc false
  import Ra.Internal.Forget, only: [forget: 1]
  import Ra.Internal.Bag.Tuple, only: [fst: 1, snd: 1]

  def first(forget(z)), do: forget(&z.(fst(&1)))
  def second(forget(z)), do: forget(&z.(snd(&1)))
end

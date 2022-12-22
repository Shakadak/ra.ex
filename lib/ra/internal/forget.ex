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
  import Ra.Internal.Bag.Pair, only: [fst: 1, snd: 1]

  def first(forget(z)), do: forget(&z.(fst(&1)))
  def second(forget(z)), do: forget(&z.(snd(&1)))
end

defmodule Ra.Semigroup.Forget do
  def mk(type) do
    %{
      Ra.Semigroup => %{
        append: &append(&1, &2, type),
      }
    }
  end

  require Ra.Semigroup

  def append(f, g, semigroup), do: fn x -> Ra.Semigroup.append(f.(x), g.(x), semigroup) end
end

defmodule Ra.Monoid.Forget do
  def mk(type) do
    semigroup = Ra.Semigroup.Forget.mk(type)
    monoid = %{
      Ra.Monoid => %{
        mempty: fn -> mempty(type) end,
      },
    }
    Map.merge(semigroup, monoid)
  end

  require Ra.Monoid

  def mempty(monoid), do: fn _ -> Ra.Monoid.mempty(monoid) end
end

defmodule Ra.Profunctor.Choice.Forget do
  import Ra.Internal.Forget, only: [forget: 1]
  import Ra.Internal.Bag.Either, only: [either: 3]

  # instance choiceForget :: Monoid r => Choice (Forget r) where

  require Ra.Monoid

  def mk(monoid) do
    dict = Ra.Monoid.Forget.mk(monoid)
    %{
      Ra.Profunctor => Ra.Profunctor.Forget,
      Ra.Profunctor.Choice => %{
        left: &left(&1, dict),
        right: &right(&1, dict),
      }
    }
  end

  def left(forget(z), monoid), do: forget(&either(z, Ra.Monoid.mempty(monoid), &1))
  def right(forget(z), monoid), do: forget(&either(Ra.Monoid.mempty(monoid), z, &1))
end

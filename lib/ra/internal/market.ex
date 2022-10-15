defmodule Ra.Internal.Market do
  @moduledoc false
  import PatternMetonyms

  @doc """
  The `Market` profunctor characterizes a `Prism`.
  ```purescript
  data Market a b s t = Market (b -> t) (s -> Either t a)
  ```
  """
  pattern market(bt, seta) = {:Market, bt, seta}
end

defmodule Ra.Functor.Market do
  @moduledoc false
  import Ra.Internal.Market, only: [market: 2]

  def map(f, market(a, b)) do
    market(&f.(a.(&1)), &Ra.Bimap.Either.lmap(f, b.(&1)))
  end
end

defmodule Ra.Profunctor.Market do
  @moduledoc false
  import Ra.Internal.Market, only: [market: 2]

  def dimap(f, g, market(a, b)) do
    market(&g.(a.(&1)), &Ra.Bimap.Either.lmap(g, b.(f.(&1))))
  end
end

defmodule Ra.Profunctor.Choice.Market do
  @moduledoc false
  import Ra.Internal.Market, only: [market: 2]

  alias Ra.Internal.Bag.Either
  require Either

  def left(market(x, y)) do
    on_left = fn t -> Ra.Bimap.Either.lmap(&Either.left/1, y.(t)) end
    on_right = &Either.left(Either.right(&1))
    market(&Either.left(x.(&1)), &Either.either(on_left, on_right, &1))
  end

  def right(market(x, y)) do
    on_left = &Either.left(Either.left(&1))
    on_right = fn a -> Ra.Bimap.Either.lmap(&Either.right/1, y.(a)) end
    market(&Either.right(x.(&1)), &Either.either(on_left, on_right, &1))
  end
end

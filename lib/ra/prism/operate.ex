defmodule Ra.Prism.Operate do

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()

  @doc """
  ```purescript
  withPrism :: forall s t a b r. APrism s t a b -> ((b -> t) -> (s -> Either t a) -> r) -> r
  ```
  """
  def withPrism(p, f) do
    import Ra.Internal.Market, only: [market: 2]
    import Ra.Internal.Bag.Function, only: [id: 1]
    alias Ra.Internal.Bag.Either
    require Either

    case p.(Market).(market(&id/1, &Either.right/1)) do
      market(g, h) -> f.(g, h)
    end
  end

  @doc """
  ```purescript
  matching :: forall s t a b. APrism s t a b -> s -> Either t a
  ```
  """
  def matching(optic, data) do
    withPrism(optic, fn _, f -> f.(data) end)
  end

  @doc """
  Ask if `preview prism` would produce a `Just`.
  ```purescript
  is :: forall s t a b r. HeytingAlgebra r => APrism s t a b -> s -> r
  ```
  """
  def is(optic, data) do
    import Ra.Internal.Bag.Either, only: [either: 3]
    import Ra.Internal.Bag.Function, only: [const: 2]
    either(&const(false, &1), &const(true, &1), matching(optic, data))
  end

  @doc """
  Ask if `preview prism` would produce a `Nothing`.
  ```purescript
  isn't :: forall s t a b r. HeytingAlgebra r => APrism s t a b -> s -> r
  ```
  """
  def isn_t(optic, data), do: not is(optic, data)

  @doc """
  Create the "whole" corresponding to a specific "part":

  ```purescript
  review solidFocus Color.white == Solid Color.white
  ```

  ```purescript
  review :: forall s t a b. Review s t a b -> b -> t
  ```
  """
  def review(p, b) do
    import Ra.Internal.Tagged, only: [tagged: 1]
    case p.(Tagged).(tagged(b)) do
      tagged(x) -> x
    end
  end
end

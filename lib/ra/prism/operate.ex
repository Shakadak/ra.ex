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
  def matching(p, s) do
    withPrism(p, fn _, f -> f.(s) end)
  end

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

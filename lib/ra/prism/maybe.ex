defmodule Ra.Prism.Maybe do
  alias Ra.Internal.Bag.Either
  alias Ra.Internal.Bag.Maybe
  alias Ra.Internal.Bag.Unit

  import Ra.Internal.Bag.Function, only: [const: 2]
  import Either, only: [left: 1, right: 1]
  import Maybe, only: [just: 1, nothing: 0, maybe: 3]
  import Unit, only: [unit: 0]
  import Ra.Prism, only: [prism: 2]

  @doc """
  Prism for the `Nothing` constructor of `Maybe`.
  ```purescript
  _Nothing :: forall a b. Prism (Maybe a) (Maybe b) Unit Unit
  ```

      iex> Ra.Prism.review(Ra.Prism.Maybe._Nothing(), 2)
      :Nothing
  """
  def _Nothing do
    to = &const(nothing(), &1)
    from = fn x -> maybe(right(unit()), &const(left(nothing()), &1), x) end
    prism(to, from)
  end

  @doc """
  Prism for the `Just` constructor of `Maybe`.
  ```purescript
  _Just :: forall a b. Prism (Maybe a) (Maybe b) a b
  ```

      iex> Ra.Prism.review(Ra.Prism.Maybe._Just(), 2)
      {:Just, 2}
  """
  def _Just do
    to = &just/1
    from = fn x -> maybe(left(nothing()), &right/1, x) end
    prism(to, from)
  end
end

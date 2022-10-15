defmodule Ra.Prism.Construct do

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()

  @doc """
  Create a `Prism` from a constructor and a matcher function that
  produces an `Either`:

  ```purescript
  solidFocus :: Prism' Fill Color
  solidFocus = prism Solid case _ of
    Solid color -> Right color
    anotherCase -> Left anotherCase
  ```

  _Note_: The matcher function returns a result wrapped in `Either t`
  to allow for type-changing prisms in the case where the input does
  not match.
  ```
  prism :: forall s t a b. (b -> t) -> (s -> Either t a) -> Prism s t a b
  ```
  """
  def prism(to, from) do
    fn choice -> fn pab ->
      import Ra.Profunctor, only: [dimap: 4, rmap: 3]
      import Ra.Profunctor.Choice, only: [right: 2]
      import Ra.Internal.Bag.Function, only: [id: 1]
      import Ra.Internal.Bag.Either, only: [either: 3]
      out = fn x -> either(&id/1, &id/1, x) end
      dimap(from, out, right(rmap(to, pab, choice), choice), choice)
    end end
  end

  @doc """
  Create a `Prism` from a constructor and a matcher function that
  produces a `Maybe`:

  ```purescript
  solidFocus :: Prism' Fill Color
  solidFocus = prism' Solid case _ of
    Solid color -> Just color
    _ -> Nothing
  ```
  ```purescript
  prism' :: forall s a. (a -> s) -> (s -> Maybe a) -> Prism' s a
  ```
  """
  def prism_(to, from) do
    import Ra.Internal.Bag.Either, only: [left: 1, right: 1]
    import Ra.Internal.Bag.Maybe, only: [maybe: 3]
# prism' to fro = prism to (\s -> maybe (Left s) Right (fro s))
    prism(to, fn s -> maybe(left(s), &right/1, from.(s)) end)
  end
end

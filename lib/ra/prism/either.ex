defmodule Ra.Prism.Either do
  import Ra.Profunctor.Choice, only: [left: 2, right: 2]

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()

  @doc """
  Prism for the `Left` constructor of `Either`.
  ```purescript
  _Left :: forall a b c. Prism (Either a c) (Either b c) a b
  ```

      iex> use Ra.Data
      iex> use Ra.Optics
      iex> Ra.Prism.review(_Left(), 2)
      left(2)
      iex> Ra.Setter.set(_Left(), 0, left(4))
      left(0)
      iex> Ra.Setter.set(_Left(), 0, right(4))
      right(4)
      iex> Ra.Setter.over(_Left(), fn n -> n + 6 end, left(4))
      left(10)
      iex> Ra.Setter.over(_Left(), fn n -> n + 6 end, right(4))
      right(4)
      iex> Ra.Prism.matching(_Left(), left(4))
      right(4)
      iex> Ra.Prism.matching(_Left(), right(4))
      left(right(4))
  """
  def _Left, do: fn choice -> fn pab -> left(pab, choice) end end

  @doc """
  Prism for the `Right` constructor of `Either`.
  ```purescript
  _Right :: forall a b c. Prism (Either c a) (Either c b) a b
  ```

      iex> use Ra.Data
      iex> use Ra.Optics
      iex> Ra.Prism.review(_Right(), 2)
      right(2)
      iex> Ra.Setter.set(_Right(), 0, right(4))
      right(0)
      iex> Ra.Setter.set(_Right(), 0, left(4))
      left(4)
      iex> Ra.Setter.over(_Right(), fn n -> n + 6 end, right(4))
      right(10)
      iex> Ra.Setter.over(_Right(), fn n -> n + 6 end, left(4))
      left(4)
      iex> Ra.Prism.matching(_Right(), right(4))
      right(4)
      iex> Ra.Prism.matching(_Right(), left(4))
      left(left(4))
  """
  def _Right, do: fn choice -> fn pab -> right(pab, choice) end end
end

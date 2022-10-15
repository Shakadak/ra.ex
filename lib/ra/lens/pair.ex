defmodule Ra.Lens.Pair do
  import Ra.Profunctor.Strong, only: [first: 2, second: 2]

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()

  @doc """
  Lens for the first component of a 2-`Pair`.
  ```purescript
  _1 :: forall a b c. Lens (Pair a c) (Pair b c) a b
  ```

      iex> use Ra.Data
      iex> use Ra.Optics
      iex> use Ra.Operate
      iex> view(_1(), {3, 4})
      3
      iex> set(_1(), 0, {4, :a})
      {0, :a}
      iex> over(_1(), fn n -> n + 6 end, {4, :a})
      {10, :a}
  """
  def _1, do: fn strong -> fn pab -> first(pab, strong) end end

  @doc """
  Lens for the second component of a 2-`Pair`.
  ```purescript
  _2 :: forall a b c. Lens (Pair c a) (Pair c b) a b
  ```

      iex> use Ra.Data
      iex> use Ra.Optics
      iex> use Ra.Operate
      iex> view(_2(), {3, 4})
      4
      iex> set(_2(), :b, {4, :a})
      {4, :b}
      iex> over(_2(), fn _ -> :b end, {4, :a})
      {4, :b}
  """
  def _2, do: fn strong -> fn pab -> second(pab, strong) end end
end

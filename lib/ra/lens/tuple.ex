defmodule Ra.Lens.Tuple do
  import Ra.Profunctor.Strong, only: [first: 2, second: 2]

  @doc """
  Lens for the first component of a 2-`Tuple`.
  ```purescript
  _1 :: forall a b c. Lens (Tuple a c) (Tuple b c) a b
  ```

      iex> Ra.Getter.view(Ra.Lens.Tuple._1, {3, 4})
      3
  """
  def _1, do: fn strong -> fn pab -> first(pab, strong) end end

  @doc """
  Lens for the second component of a 2-`Tuple`.
  ```purescript
  _2 :: forall a b c. Lens (Tuple c a) (Tuple c b) a b
  ```

      iex> Ra.Getter.view(Ra.Lens.Tuple._2, {3, 4})
      4
  """
  def _2, do: fn strong -> fn pab -> second(pab, strong) end end
end

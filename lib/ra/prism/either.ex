defmodule Ra.Prism.Either do
  import Ra.Profunctor.Choice, only: [left: 2, right: 2]

  @doc """
  Prism for the `Left` constructor of `Either`.
  ```purescript
  _Left :: forall a b c. Prism (Either a c) (Either b c) a b
  ```
  """
  def _Left, do: fn choice -> fn pab -> left(pab, choice) end end

  @doc """
  Prism for the `Right` constructor of `Either`.
  ```purescript
  _Left :: forall a b c. Prism (Either a c) (Either b c) a b
  ```
  """
  def _Right, do: fn choice -> fn pab -> right(pab, choice) end end
end

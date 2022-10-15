defmodule Ra.Internal.Tagged do
  @moduledoc false
  import PatternMetonyms

  @doc """
  ```purescript
  newtype Tagged :: forall k. k -> Type -> Type
  newtype Tagged a b = Tagged b
  ```
  """
  pattern tagged(b) = {:Tagged, b}
end

defmodule Ra.Profunctor.Tagged do
  @moduledoc false
  import Ra.Internal.Tagged, only: [tagged: 1]

  def dimap(_, g, tagged(x)), do: tagged(g.(x))
end

defmodule Ra.Profunctor.Choice.Tagged do
  @moduledoc false
  import Ra.Internal.Tagged, only: [tagged: 1]
  alias Ra.Internal.Bag.Either
  require Either

  def left(tagged(x)), do: tagged(Either.left(x))
  def right(tagged(x)), do: tagged(Either.right(x))
end

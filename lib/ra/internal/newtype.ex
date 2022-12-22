defmodule Ra.Internal.Bag.Newtype do

  alias Ra.Internal.Meta.Class
  require Class

  @doc """
  ```purescript
  wrap :: forall t a. Newtype t a => a -> t
  ```
  """
  Class.mk :wrap, 1

  @doc """
  ```purescript
  unwrap :: forall t a. Newtype t a => t -> a
  ```
  """
  Class.mk :unwrap, 1

  def over(_to, _f, _data) do
  end

  def under(_to, _f, _data) do
  end
end

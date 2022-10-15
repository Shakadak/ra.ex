defmodule Ra.Profunctor.Choice do
  alias Ra.Internal.Meta.Class
  require Class

  @doc "left :: forall a b c. p a b -> p (Either a c) (Either b c)"
  Class.mk :left, 1
  @doc "right :: forall a b c. p b c -> p (Either a b) (Either a c)"
  Class.mk :right, 1
end

defmodule Ra.Profunctor.Choice.Function do
  @moduledoc false

  #alias Ra.Internal.Bag.Either
  #require Either
  use Ra.Data

  def left(a2c), do: fn
    Either.left(a) -> Either.left(a2c.(a))
    Either.right(_) = x -> x
  end

  def right(b2c), do: fn
    Either.left(_) = x -> x
    Either.right(b) -> Either.right(b2c.(b))
  end
end

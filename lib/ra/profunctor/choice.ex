defmodule Ra.Profunctor.Choice do
  alias Ra.Internal.Class
  require Class

  @doc "left :: forall a b c. p a b -> p (Either a c) (Either b c)"
  Class.mk :left, 1
  @doc "right :: forall a b c. p b c -> p (Either a b) (Either a c)"
  Class.mk :right, 1
end

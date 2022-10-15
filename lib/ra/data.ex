defmodule Ra.Data do
  defmacro __using__(_opts) do
    quote do
      alias Ra.Internal.Bag.Unit
      alias Ra.Internal.Bag.Maybe
      alias Ra.Internal.Bag.Pair
      alias Ra.Internal.Bag.Either

      import Unit
      import Maybe
      import Pair
      import Either
    end
  end
end

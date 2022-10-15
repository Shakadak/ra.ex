defmodule Ra.Types do
  defmacro __using__([]) do
    quote do
      import Ra.Internal.Exchange, only: [exchange: 2]
    end
  end

  #defmacro exchange(x, y) do
  #  quote do require Ra.Internal.Exchange ; Ra.Internal.Exchange.exchange(unquote(x), unquote(y)) end
  #end
end

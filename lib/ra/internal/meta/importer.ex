defmodule Ra.Internal.Meta.Importer do
  @moduledoc false

  defmacro mk_using do
    quote do
      defmacro __using__(_opts) do
        fns =
          __MODULE__.__info__(:functions)
        quote do
          import unquote(__MODULE__), only: unquote(fns)
        end
        #|> case do x -> _ = IO.puts("use #{inspect(__MODULE__)} ->\n#{Macro.to_string(x)}") ; x end
      end
    end
  end
end

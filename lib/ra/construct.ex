defmodule Ra.Construct do
  defmacro __using__(_opts) do
    quote do
      use Ra.Prism.Construct
      use Ra.Getter.Construct

      :constructible
    end
  end
end

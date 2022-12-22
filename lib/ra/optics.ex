defmodule Ra.Optics do
  defmacro __using__(_opts) do
    quote do
      use Ra.Lens.Pair
      use Ra.Prism.Maybe
      use Ra.Prism.Either

      :visible
    end
  end
end

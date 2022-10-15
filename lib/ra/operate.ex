defmodule Ra.Operate do
  defmacro __using__(_opts) do
    quote do
      use Ra.Prism.Operate
      use Ra.Getter.Operate
      use Ra.Setter.Operate

      import Ra
    end
  end
end

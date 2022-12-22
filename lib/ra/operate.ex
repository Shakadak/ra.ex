defmodule Ra.Operate do
  defmacro __using__(_opts) do
    quote do
      use Ra.Prism.Operate
      use Ra.Getter.Operate
      use Ra.Setter.Operate
      use Ra.Fold.Operate

      import Ra

      :operable
    end
  end
end

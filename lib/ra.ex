defmodule Ra do

  defmacro __using__(_opts) do
    quote do
      # The data types
      use Ra.Data
      # The optics to operate on them
      use Ra.Optics
      # The functions to use the optics
      use Ra.Operate
      # The function to create more optics
      use Ra.Construct

      import Ra

      :shining
    end
  end

  @doc """
  Compose a list of optics.

      iex> use Ra.Optics
      iex> use Ra.Operate
      iex> view(compose(List.duplicate(_1(), 3)), {{{:ok, 3}, 2}, 1})
      :ok
      iex> view(compose([_1(), _2()]), {{{:ok, 3}, 2}, 1})
      2
  """
  def compose([o]), do: o
  def compose(os) when is_list(os) do
    fn type -> fn pab ->
      List.foldr(os, pab, fn o, pcd -> o.(type).(pcd) end)
    end end
  end
end

defmodule Ra do
  @doc """
  Compose a list of optics.

      iex> import Ra.Lens.Pair, only: [_1: 0, _2: 0]
      iex> Ra.Getter.view(Ra.compose(List.duplicate(_1(), 3)), {{{:ok, 3}, 2}, 1})
      :ok
      iex> Ra.Getter.view(Ra.compose([_1(), _2()]), {{{:ok, 3}, 2}, 1})
      2
  """
  def compose([o]), do: o
  def compose(os) when is_list(os) do
    fn type -> fn pab ->
      List.foldr(os, pab, fn o, pcd -> o.(type).(pcd) end)
    end end
  end
end

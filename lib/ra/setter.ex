defmodule Ra.Setter do
  import Ra.Internal.Bag.Function, only: [const: 2]

  @doc """
  Apply a function to the foci of a `Setter`.
      over :: forall s t a b. Setter s t a b -> (a -> b) -> s -> t
  """
  def over(o, ab, s) do
    o.(Function).(ab).(s)
  end

  @doc """
  Set the foci of a `Setter` to a constant value.
      set :: forall s t a b. Setter s t a b -> b -> s -> t
  """
  def set(o, b, s) do
    o.(Function).(&const(b, &1)).(s)
  end
end

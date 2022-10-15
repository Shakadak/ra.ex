defmodule Ra.Setter do
  import Ra.Internal.Bag.Function, only: [const: 2]

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()

  @doc """
  Apply a function to the foci of a `Setter`.
      over :: forall s t a b. Setter s t a b -> (a -> b) -> s -> t
  """
  def over(optic, updater, data) do
    optic.(Function).(updater).(data)
  end

  @doc """
  Set the foci of a `Setter` to a constant value.
      set :: forall s t a b. Setter s t a b -> b -> s -> t
  """
  def set(optic, value, data) do
    optic.(Function).(&const(value, &1)).(data)
  end
end

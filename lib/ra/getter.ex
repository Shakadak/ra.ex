defmodule Ra.Getter do
  @doc """
  View the focus of a `Getter`.
      view :: forall s t a b. AGetter s t a b -> s -> a
  """
  def view(o, s) do
    import Ra.Internal.Bag.Function, only: [id: 1]
    import Ra.Internal.Forget, only: [forget: 1]
    forget(f) = o.(Forget).(forget(&id/1))
    f.(s)
  end

  @doc """
  Convert a function into a getter.
      to :: forall s t a b. (s -> a) -> Getter s t a b
  """
  def to(f, p) do
    import Ra.Internal.Forget, only: [forget: 1]
    forget(p) = p
    forget(&p.(f.(&1)))
  end
end

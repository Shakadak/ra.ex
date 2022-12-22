defmodule Ra.Getter.Operate do

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()

  @doc """
  View the focus of a `Getter`.
      view :: forall s t a b. AGetter s t a b -> s -> a
  """
  def view(optic, data) do
    import Ra.Internal.Bag.Function, only: [id: 1]
    import Ra.Internal.Forget, only: [forget: 1]
    forget(f) = optic.(Forget).(forget(&id/1))
    f.(data)
  end
end

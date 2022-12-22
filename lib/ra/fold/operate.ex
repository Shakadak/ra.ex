defmodule Ra.Fold.Operate do

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()

  @doc """
  Previews the first value of a fold, if there is any.
  ```purescript
  preview :: forall s t a b. Fold (First a) s t a b -> s -> Maybe a
  ```
  """
  def preview(optic, data) do
    import Ra.Internal.Bag.Maybe, only: [just: 1]
    import Ra.Internal.Bag.First, only: [first: 1]
    first(x) = foldMapOf(optic, &first(just(&1)), data, First)
    x
  end

  @doc """
  Synonym for `preview`, flipped.
  ```purescript
  previewOn :: forall s t a b. s -> Fold (First a) s t a b -> Maybe a
  ```
  """
  def previewOn(data, optic), do: preview(optic, data)

  def foldOf(optic, data, monoid) do
    import Ra.Internal.Bag.Function, only: [id: 1]
    foldMapOf(optic, &id/1, data, monoid)
  end

  #def view(optic, data) do
  #  import Ra.Internal.Bag.Function, only: [id: 1]
  #  import Ra.Internal.Forget, only: [forget: 1]
  #  forget(f) = optic.(Forget).(forget(&id/1))
  #  f.(data)
  #end

  def foldMapOf(optic, f, data, monoid) do
    import Ra.Internal.Forget, only: [forget: 1]
    dict = Ra.Profunctor.Choice.Forget.mk(monoid)
    forget(g) = optic.(dict).(forget(f))
    g.(data)
  end
end

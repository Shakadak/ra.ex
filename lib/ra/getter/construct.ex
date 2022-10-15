defmodule Ra.Getter.Construct do

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()

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

defmodule Ra.Internal.Exchange do
  @moduledoc false

  import PatternMetonyms

  @doc """
  The `Exchange` profunctor characterizes an `Iso`.
      data Exchange a b s t = Exchange (s -> a) (b -> t)
  """
  pattern exchange(sa, bt) = {:Exchange, sa, bt}
end

defmodule Ra.Functor.Exchange do
  @moduledoc false
  import Ra.Internal.Exchange, only: [exchange: 2]

  def map(f, exchange(a, b)), do: exchange(a, &f.(b.(&1)))
end

defmodule Ra.Profunctor.Exchange do
  @moduledoc false
  import Ra.Internal.Exchange, only: [exchange: 2]

  def dimap(f, g, exchange(a, b)), do: exchange(&f.(a.(&1)), &g.(b.(&1)))
end

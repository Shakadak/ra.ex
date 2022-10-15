defmodule Ra.Internal.Bag.Either do
  @moduledoc false

  import PatternMetonyms

  pattern left(a) = {:Left, a}
  pattern right(b) = {:Right, b}

  def either(f, _, left(x)), do: f.(x)
  def either(_, g, right(y)), do: g.(y)

  def plus(f, g) do
    fn
      left(x) -> left(f.(x))
      right(y) -> right(g.(y))
    end
  end
end

defmodule Ra.Bimap.Either do
  @moduledoc false

  import Ra.Internal.Bag.Either, only: [left: 1, right: 1]
  def lmap(f, left(x)), do: left(f.(x))
  def lmap(_, right(_) = e_x), do: e_x
end

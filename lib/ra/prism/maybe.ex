defmodule Ra.Prism.Maybe do
  alias Ra.Internal.Bag.Either
  alias Ra.Internal.Bag.Maybe
  alias Ra.Internal.Bag.Unit

  import Ra.Internal.Bag.Function, only: [const: 2]
  import Either, only: [left: 1, right: 1]
  import Maybe, only: [just: 1, nothing: 0, maybe: 3]
  import Unit, only: [unit: 0]
  import Ra.Prism.Construct, only: [prism: 2]

  require Ra.Internal.Meta.Importer
  Ra.Internal.Meta.Importer.mk_using()


  @doc """
  Prism for the `Nothing` constructor of `Maybe`.
  ```purescript
  _Nothing :: forall a b. Prism (Maybe a) (Maybe b) Unit Unit
  ```

      iex> use Ra.Data
      iex> use Ra.Optics
      iex> use Ra.Operate
      iex> review(_Nothing(), 2)
      nothing()
      iex> set(_Nothing(), 0, just(4))
      nothing()
      iex> set(_Nothing(), 0, nothing())
      nothing()
      iex> over(_Nothing(), fn unit() -> 10 end, just(4))
      nothing()
      iex> over(_Nothing(), fn unit() -> 10 end, nothing())
      nothing()
      iex> matching(_Nothing(), just(4))
      left(nothing())
      iex> matching(_Nothing(), nothing())
      right(unit())
  """
  def _Nothing do
    to = &const(nothing(), &1)
    from = fn x -> maybe(right(unit()), &const(left(nothing()), &1), x) end
    prism(to, from)
  end

  @doc """
  Prism for the `Just` constructor of `Maybe`.
  ```purescript
  _Just :: forall a b. Prism (Maybe a) (Maybe b) a b
  ```

      iex> use Ra.Data
      iex> use Ra.Optics
      iex> use Ra.Operate
      iex> review(_Just(), 2)
      just(2)
      iex> set(_Just(), 0, just(4))
      just(0)
      iex> set(_Just(), 0, nothing())
      nothing()
      iex> over(_Just(), fn n -> n + 6 end, just(4))
      just(10)
      iex> over(_Just(), fn n -> n + 6 end, nothing())
      nothing()
      iex> matching(_Just(), just(4))
      right(4)
      iex> matching(_Just(), nothing())
      left(nothing())
  """
  def _Just do
    to = &just/1
    from = fn x -> maybe(left(nothing()), &right/1, x) end
    prism(to, from)
  end
end

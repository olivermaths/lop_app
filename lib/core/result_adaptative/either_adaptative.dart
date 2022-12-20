abstract class Either<L, R> {
  dynamic fold(Function(L l) L, Function(R r) R);
}

class Left<L, R> implements Either<L, R> {
  final L _value;
  Left(this._value);

  @override
  dynamic fold(Function(L l) L, Function(R r) R) => L(_value);
}

class Right<L, R> implements Either<L, R> {
  final R _value;
  Right(this._value);

  @override
  dynamic fold(Function(L l) L, Function(R r) R) => R(_value);
}

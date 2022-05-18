
abstract class UseCase<T, P>{
  Future<T> execute(P parameters);
}

abstract class UseCase<R, T> {
  final R _repository;

  UseCase(this._repository);

  R get repository => _repository;

  void call({T params});
}

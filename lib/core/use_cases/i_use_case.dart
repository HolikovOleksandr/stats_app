abstract class IUseCase<Output, Input> {
  Future<Output> execute(Input params);
}

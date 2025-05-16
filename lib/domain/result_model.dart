sealed class Resource<T> {
  final T? result;
  final String? errorMessage;

  Resource({this.result, this.errorMessage});
}

class Success<T> extends Resource<T> {
  Success(T? result) : super(result: result);
}

class Fail<T> extends Resource<T> {
  Fail(String? errorMessage) : super(errorMessage: errorMessage);
}

extension ResourceExtension<T> on Resource<T> {
  Resource<T> success(void Function(T?) result) {
    if (this is Success<T>) {
      result((this as Success<T>).result);
    }
    return this;
  }

  Resource<T> fail(void Function(String?) error) {
    if (this is Fail<T>) {
      error((this as Fail<T>).errorMessage);
    }
    return this;
  }
}

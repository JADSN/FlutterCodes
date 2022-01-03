import 'package:fluttask/exceptions/result.dart';

abstract class IFecthHttp<T, U> {
  Future<Result<List<T>>> readAll();
  Future<Result<T>> insertOne(U data);
  Future<Result<void>> deleteOne(int identifier);
}

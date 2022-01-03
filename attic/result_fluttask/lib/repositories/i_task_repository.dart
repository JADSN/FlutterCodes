import 'package:fluttask/shared/i_fetch_http.dart';
import 'package:fluttask/exceptions/result.dart';
import 'package:fluttask/models/task_model.dart';

mixin ITaskRepository<T, U> implements IFecthHttp<T, U> {
  @override
  Future<Result<List<T>>> readAll();

  @override
  Future<Result<T>> insertOne(U data);

  @override
  Future<Result<void>> deleteOne(int identifier);

  Future<Result<void>> updateDescription(
    TaskUpdateDescription newValue,
    int identifier,
  );

  Future<Result<void>> updateIsDone(
    TaskUpdateIsDone newValue,
    int identifier,
  );
}

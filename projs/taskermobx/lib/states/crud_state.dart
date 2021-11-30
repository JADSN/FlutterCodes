enum CrudState { nop, reading, creating, updating, deleting }

extension ParseToString on CrudState {
  String convToString() {
    return toString().split('.').last;
  }
}

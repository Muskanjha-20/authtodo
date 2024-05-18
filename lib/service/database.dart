import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saaski_app/models/todo.dart';

String TODO_COLLECTION_REF = "Todos";

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _todosRef;

  DatabaseServices() {
    _todosRef = _firestore.collection(TODO_COLLECTION_REF).withConverter<Todo>(
        fromFirestore: (snapshots, _) => Todo.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (todo, _) => todo.toJson());
  }

  Stream<QuerySnapshot> getTodos() {
    return _todosRef.snapshots();
  }

  void addTodo(Todo todo) async {
    _todosRef.add(todo);
  }
}

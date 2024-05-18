import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saaski_app/screens/homescreen/switch_button.dart'; // Assuming you need this import for other functionality
import 'package:saaski_app/screens/homescreen/task_boxes.dart';
import 'package:saaski_app/service/database.dart';

import '../../models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseServices _databaseServices = DatabaseServices();
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: StreamBuilder(
          stream: _databaseServices.getTodos(),
          builder: (context, snapshot) {
            List Todos = snapshot.data?.docs ?? [];
            if (Todos.isEmpty) {
              return Center(
                child: Text("data"),
              );
            }
            print(Todos);
            return ListView.builder(
              itemCount: Todos.length,
              itemBuilder: (context, index) {
                // Todo todo = Todos[index].data();
                String todoId = Todos[index].id;
                print(Todos);
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TaskBox(),
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            openBox();
          }),
    );
  }

  Future openBox() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      "Add the task",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("Add Title"),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Title",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Add Description"),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Description",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Select Date"),
                const SizedBox(
                  height: 7,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Choose",
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Add"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

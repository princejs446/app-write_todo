import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tasks = []; 
  TextEditingController taskController = TextEditingController(); 
  int? editingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do App", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tasks[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                     
                      taskController.text = tasks[index];
                      setState(() {
                        editingIndex = index;
                      });
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: taskController,
                                  decoration: InputDecoration(
                                    labelText: 'Edit task',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 55),
                                SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (taskController.text.isNotEmpty) {
                                        setState(() {
                                          tasks[editingIndex!] = taskController.text; 
                                          editingIndex = null; 
                                        });
                                        taskController.clear(); 
                                        Navigator.pop(context); 
                                      }
                                    },
                                    child: Text("Save"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  // Delete Button
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index); 
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            editingIndex = null; 
          });
          taskController.clear(); 

          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      controller: taskController,
                      decoration: InputDecoration(
                        labelText: 'Add task',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 55),
                    SizedBox(
                      height: 40,
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          if (taskController.text.isNotEmpty) {
                            setState(() {
                              tasks.add(taskController.text); 
                            });
                            taskController.clear(); 
                            Navigator.pop(context); 
                          }
                        },
                        child: Text("Add"),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Text("+"),
      ),
    );
  }
}

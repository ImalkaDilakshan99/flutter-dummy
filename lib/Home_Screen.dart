import 'package:dummy_app/ApiCallScreen.dart';
import 'package:dummy_app/Contact.dart';
import 'package:dummy_app/style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = List.empty(growable: true);

  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();

  var selectIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'contact app',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Apicallscreen(),
                  ),
                );
              },
              child: const Text('Go API Call'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: apptextfielddecoration.main(hinttext: "Enter name"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: numController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: apptextfielddecoration.main(hinttext: "Enter number"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String number = numController.text.trim();
                    if (name.isNotEmpty && number.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        numController.text = '';
                        contacts.add(Contact(name: name, number: number));
                      });
                    }
                  },
                  child: const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String number = numController.text.trim();
                    if (name.isNotEmpty && number.isNotEmpty) {
                      setState(() {
                        contacts[selectIndex].name = name;
                        contacts[selectIndex].number = number;
                        nameController.text = '';
                        numController.text = '';
                        selectIndex = -1;
                      });
                    }
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: contacts.isEmpty
                  ? Center(child: const Text("No Contacts"))
                  : ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, Index) => Card(
                        child: ListTile(
                          title: Column(
                            children: [
                              Text(contacts[Index].name),
                              Text(contacts[Index].number),
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Index % 2 == 0
                                ? Colors.red
                                : Colors.yellow,
                            child: Text(contacts[Index].name[0]),
                            foregroundColor: Colors.white,
                          ),
                          trailing: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                GestureDetector(
                                  child: Icon(Icons.edit),
                                  onTap: () {
                                    selectIndex = Index;
                                    nameController.text = contacts[Index].name;
                                    numController.text = contacts[Index].number;
                                  },
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  child: Icon(Icons.delete),
                                  onTap: () {
                                    setState(() {
                                      contacts.removeAt(Index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

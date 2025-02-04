import 'package:flutter/material.dart';

void main () {
  runApp(AssignmentApp());
}

class AssignmentApp extends StatelessWidget{
  const AssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
       debugShowCheckedModeBanner:false,
       home:ContactPage());
  }

}

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  List<Map<String, String>> _contacts =[];

  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  _addContacts() {
    setState(() {
      _contacts.add({
        'name': _nameController.text,
        'number': _numberController.text,
      });

      _nameController.clear();
      _numberController.clear();
    });
  }
  _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  _showConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Conforming'),
          content: Text('Are you sure you for Delete?'),
          actions: [
            IconButton(onPressed:(){
              Navigator.of(context).pop();

            } , icon:Icon(Icons.browser_not_supported_sharp)),
            IconButton(
              onPressed: () {
                _deleteContact(index);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.delete),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Contact List',
            style: TextStyle(fontSize: 25, color: Colors.white,)),
      ),
      body: Padding(padding: EdgeInsets.only(left: 8, top: 12, right: 8,),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                  hintText: 'Number',
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(
              height: 14,),
            Container(
              height: 45,
              width: 500,
              child: ElevatedButton(onPressed:_addContacts,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))
                  ),
                  child: Text('Add', style: TextStyle(color: Colors.white),)),
            ),
            SizedBox(height: 8,),
            Expanded(
              child: ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_contacts[index]['name']!,
                          style: TextStyle(
                            color: Colors.green) ,),

                        subtitle: Text(_contacts[index]['number']!),
                        leading: Icon(Icons.person_2_rounded,color:Colors.blue,),
                        trailing: Icon(Icons.phone,color: Colors.blue,),
                        onLongPress: () {
                          _showConfirmationDialog(context, index);
                        },

                      ),
                    );
                  }),
            )
          ],
        ),

      ),
    );
  }

}



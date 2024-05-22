import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_getx/hive/hive_todo/boxes/boxes_notes.dart';
import 'package:todo_getx/hive/hive_todo/notes_model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'notes_model.dart';


class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final typeController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final ageController = TextEditingController();
  final colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       flexibleSpace: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [Colors.deepPurple, Colors.purple.shade300],
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
           ),
         ),
       ),
       title:Text(
        "Hamza's Farm",
         style: GoogleFonts.allison(
             fontSize: 30,
             fontWeight: FontWeight.w700,
             fontStyle: FontStyle.italic,
             color: Colors.black45),
      ),

     ),


      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: BoxesNotes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildRow("Type:", data[index].type.toString(),
                                    Colors.pink.withOpacity(0.6)),
                                buildRow("Description:",
                                    data[index].description.toString(),
                                    Colors.black.withOpacity(0.8)),
                                buildRow("Price:", data[index].Price.toString(),
                                    Colors.pink.withOpacity(0.6)),
                                buildRow("Color / dateOfPurchase:", data[index].Color.toString(),
                                    Colors.pink.withOpacity(0.6)),
                                buildRow("Age:", data[index].age.toString(),
                                    Colors.black.withOpacity(0.8)),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                InkWell(
                                  child: Icon(Icons.edit),
                                  onTap: () {
                                    _editMyDialog(
                                      data[index],
                                      data[index].type.toString(),
                                      data[index].description.toString(),
                                      data[index].Price.toString(),
                                      data[index].age.toString(),
                                      data[index].Color.toString(),
                                    );
                                  },
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    delete(data[index]);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future<void> _editMyDialog(NotesModel notesModel, String type,
      String description, String price, String age, String color) async {
    typeController.text = type;
    descriptionController.text = description;
    priceController.text = price;
    ageController.text = age;
    colorController.text = color;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Notes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                buildTextFormField(typeController, 'Enter type'),
                SizedBox(height: 8),
                buildTextFormField(descriptionController, 'Enter description'),
                SizedBox(height: 8),
                buildTextFormField(priceController, 'Enter price'),
                SizedBox(height: 8),
                buildTextFormField(ageController, 'Enter age'),
                SizedBox(height: 8),
                buildTextFormField(colorController, 'Enter color/dateOfPurchase'),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () async {
                  notesModel.type = typeController.text;
                  notesModel.description = descriptionController.text;
                  notesModel.age = ageController.text;
                  notesModel.Price = priceController.text;
                  notesModel.Color = colorController.text;
                  await notesModel.save();
                  typeController.clear();
                  descriptionController.clear();
                  priceController.clear();
                  ageController.clear();
                  colorController.clear();
                  Navigator.of(context).pop();
                },
                child: Text("Edit")),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Notes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                buildTextFormField(typeController, 'Enter type'),
                SizedBox(height: 8),
                buildTextFormField(descriptionController, 'Enter description'),
                SizedBox(height: 8),
                buildTextFormField(priceController, 'Enter price'),
                SizedBox(height: 8),
                buildTextFormField(ageController, 'Enter age'),
                SizedBox(height: 8),
                buildTextFormField(colorController, 'Enter color/dateOfPurchas'),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  final data = NotesModel(
                    type: typeController.text,
                    description: descriptionController.text,
                    age: ageController.text,
                    Price: priceController.text,
                    Color: colorController.text,
                  );
                  final box = BoxesNotes.getData();
                  box.add(data);
                  data.save();
                  typeController.clear();
                  descriptionController.clear();
                  priceController.clear();
                  ageController.clear();
                  colorController.clear();
                  Navigator.of(context).pop();
                },
                child: Text("Add")),
          ],
        );
      },
    );
  }

  Widget buildRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.alumniSans(
              //fontWeight:FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width*0.03
            )
          ),
          SizedBox(width: 8),
          Text(
            value,
          style: GoogleFonts.almendraDisplay(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width*0.03
          ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        if(value!.isEmpty){
          return 'Text ';
        }
        return "EDIT AND FILL THE FORM";
      },
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}









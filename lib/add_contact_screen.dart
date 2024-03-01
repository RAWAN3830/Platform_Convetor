import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:plateform_convertor/modleclass.dart';
import 'package:plateform_convertor/provider.dart';
import 'package:provider/provider.dart';

var FormatedDate;
var FormatedTime;
var DatePicker;

File? gallaryImg;
PickImageFromGallary() async {
  var imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(imageFile != null)
  {
    gallaryImg = File(imageFile.path);
  }

}

class Add_contactData extends StatefulWidget {

  Add_contactData(
      {super.key,});

  @override
  State<Add_contactData> createState() => _Add_contactDataState();
}

class _Add_contactDataState extends State<Add_contactData> {

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController chatController = TextEditingController();
  final formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PlatformProvider>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key:formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: (gallaryImg != null)
                        ? Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple.shade100,
                                image: DecorationImage(
                                    image: FileImage(gallaryImg!),
                                    fit: BoxFit.cover)))
                        : InkWell(
                            onTap: () {
                            PickImageFromGallary();
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purple.shade100
                                  // gradient: LinearGradient(
                                  //     begin: Alignment.topLeft,
                                  //     colors: [Colors.redAccent, Colors.orangeAccent])
                                  ),
                              child: Center(
                                  child: Icon(
                                CupertinoIcons.camera_fill,
                                color: Colors.purple,
                                size: 40,
                              )),
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller:nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter name";
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.person, size: 25),
                          hintText: 'Full Name',
                          // enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, style: BorderStyle.solid))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: numberController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter Phone no";
                        }
                      },
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.phone_fill, size: 25),
                          hintText: 'Phone Number',
                          //enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, style: BorderStyle.solid))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: chatController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "chat is required";
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon:
                              Icon(CupertinoIcons.chat_bubble_text, size: 20),
                          hintText: 'Chat Conversation',
                          // enabledBorder:OutlineInputBorder(borderSide: BorderSide(width: 2)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, style: BorderStyle.solid))),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                             DatePicker = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025));
                            if (DatePicker != null) {
                              FormatedDate =
                                  DateFormat("dd/MM/yyyy").format(DatePicker);
                            }
                            print(DatePicker);
                          },
                          icon: Icon(Icons.date_range_outlined)),
                         Text('Pick Date',style: TextStyle(fontSize: 15),)
                      //(DatePicker != null)?Text('${FormatedDate}', style: TextStyle(fontSize: 15)) : Text('Pick Time')
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            var TimePicker = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (TimePicker != null) {
                              var dateTime = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  TimePicker.hour,
                                  TimePicker.minute);
                              FormatedTime =
                                  DateFormat('HH:mm').format(dateTime);
                              //print(FormatedTime);
                              //FormatedTime = TimePicker.format(FormatedTime);
                            }
                          },
                          icon: Icon(Icons.watch_later_outlined)),
                      Text('Time Picker', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                       formkey.currentState!.save();
                        var snakebar =
                            SnackBar(content: Text('submited Successfully'));
                        ScaffoldMessenger.of(context).showSnackBar(snakebar);
                        ModelClass data = ModelClass(
                            name: nameController.text,
                            chat:chatController.text,
                            image:gallaryImg!,
                            number: int.parse(numberController.text),
                            FormatedDate: FormatedDate,
                            FormatedTime: FormatedTime);
                        provider.addDataList(data);
                       nameController.clear();
                       numberController.clear();
                       chatController.clear();
                       gallaryImg = null;
                      },
                      child: Text(
                        '  SAVE  ',
                        style: TextStyle(fontSize: 18),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

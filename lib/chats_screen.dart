import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plateform_convertor/modleclass.dart';
import 'package:plateform_convertor/provider.dart';
import 'package:provider/provider.dart';

import 'add_contact_screen.dart';

class ChatScreen extends StatefulWidget {
  final String? name;
  final String? chat;
  final File? image;
  final int? number;
  var FormatedTime;
  var FormatedDate;
  final int? index;

   ChatScreen({super.key,
    this.name,
    this.chat,
    this.FormatedDate,
    this.FormatedTime,
    this.image,
    this.number,
    this.index});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController chatController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    if( widget.name != null &&
        widget.number != null &&
        widget.FormatedTime != null &&
        widget.FormatedDate != null &&
        widget.image != null &&
        widget.chat != null )
    {
      nameController.text = widget.name!;
      chatController.text = widget.chat!;
      numberController.text = widget.number.toString();
      FormatedDate = widget.FormatedDate;
      FormatedTime = widget.FormatedTime;
      gallaryImg = gallaryImg!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlatformProvider>(context, listen: true);
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 500,
              decoration: BoxDecoration(color: Colors.transparent),
              child: ListView.builder(
                itemCount: provider.ContactData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 350,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    CircleAvatar(
                                      backgroundImage: FileImage(
                                          provider.ContactData[index].image),
                                      radius: 70,
                                    ),
                                   // SizedBox(height: 10,),
                                    Text(
                                      provider.ContactData[index].name!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    //SizedBox(height: 10,),
                                    Text(
                                      provider.ContactData[index].chat!,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                size: 25,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(
                                                  FormatedTime:provider.ContactData[index].FormatedTime ,
                                                FormatedDate:provider.ContactData[index].FormatedDate,
                                                chat:provider.ContactData[index].chat ,
                                                index:index,
                                                name: provider.ContactData[index].name,
                                                number:provider.ContactData[index].number ,
                                                image: provider.ContactData[index].image,
                                                )));


                                                  showDialog(context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Container(
                                                        height: 500,

                                                        child: Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: (){
                                                                PickImageFromGallary();
                                                              },
                                                              child: CircleAvatar(
                                                                radius: 70,
                                                                backgroundImage:FileImage(provider.ContactData[index].image),
                                                              ),
                                                            ),
                                                            SizedBox(height: 10,),
                                                            TextFormField(
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
                                                            SizedBox(height: 10,),
                                                            TextFormField(
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
                                                            SizedBox(height: 5,),
                                                            TextFormField(
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
                                                            SizedBox(height: 10,),
                                                            Row(
                                                              children: [
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
                                                                SizedBox(width: 5,),
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

                                                              ],
                                                            ),
                                                            SizedBox(height: 10),
                                                            OutlinedButton(
                                                              style: OutlinedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(20)),
                                                              ),
                                                              onPressed: () {
                                                                ModelClass data = ModelClass(
                                                                    name: nameController.text,
                                                                    chat: chatController.text,
                                                                    FormatedTime: FormatedTime,
                                                                    FormatedDate: FormatedDate,
                                                                    image: gallaryImg!,
                                                                    number: int.parse(numberController.text));
                                                                provider.updateData(data,widget.index!);
                                                              },
                                                              child: Text(" EDIT ",
                                                                  style: TextStyle(fontSize: 20)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },);


                                                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Add_contactData(
                                                //   image:provider.ContactData[index].image,
                                                //   number:provider.ContactData[index].number,
                                                //   name: provider.ContactData[index].name,
                                                //   index:index ,
                                                //   chat: provider.ContactData[index].chat,
                                                //   FormatedDate:provider.ContactData[index].FormatedDate,
                                                //   FormatedTime:provider.ContactData[index].FormatedTime,

                                                // )));
                                              }),
                                          IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                size: 25,
                                              ),
                                              onPressed: () {}),
                                        ],
                                      ),
                                    ),

                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancle",
                                          style: TextStyle(fontSize: 20)),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        horizontalTitleGap: 10.0,
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(
                                      provider.ContactData[index].image!),
                                  fit: BoxFit.cover)),
                        ),
                        title: Text(provider.ContactData[index].name!),
                        subtitle:
                            Text(provider.ContactData[index].number.toString()),
                        trailing: Container(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(provider.ContactData[index].FormatedTime
                                  .toString()),
                              Text(provider.ContactData[index].FormatedDate
                                  .toString()),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 2,
                      )
                    ],
                  );
                },
              ))
        ],
      ),
    );
  }
}

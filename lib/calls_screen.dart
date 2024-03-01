import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

class Call_Screen extends StatefulWidget {
  const Call_Screen({super.key});

  @override
  State<Call_Screen> createState() => _Call_ScreenState();
}

class _Call_ScreenState extends State<Call_Screen> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlatformProvider>(context,listen: true);
    return  Column(
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
                        horizontalTitleGap: 10.0,
                        leading: Container( height: 60,
                          width: 60,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(
                                      provider.ContactData[index].image!),fit: BoxFit.cover)),),
                        title: Text(provider.ContactData[index].name!),
                        subtitle: Text(provider.ContactData[index].number.toString()),
                        trailing:Icon(Icons.phone,color: Colors.green,size: 28,)

                      ),
                      Divider(height: 2,thickness: 2,)
                    ],
                  );
                },)
          )

        ],

    );
  }
}

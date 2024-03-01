import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plateform_convertor/provider.dart';
import 'package:provider/provider.dart';


class Setting_Screen extends StatefulWidget {
  const Setting_Screen({super.key});

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final ThemeProvider = Provider.of<PlatformProvider>(context,listen: true);
    return Scaffold(
      body: Column(
       // crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                ListTile(
                  title: Text("Profile",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  subtitle: Text("Update Profile Data"),
                  leading: Icon(Icons.person,size: 30),
                  trailing: Switch(
                    value:isVisible, onChanged: (value) {
                      setState(() {
                        isVisible = value;
                      });
                  },
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Column(
                    children: [
                      Container(
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Divider(thickness: 2,height: 2,),

                ListTile(
                  title: Text("Theme",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  subtitle: Text("Change Theme"),
                  leading: Icon(Icons.sunny,size: 30),
                  trailing: Switch(
                    value:ThemeProvider.isDarkTheme,
                    onChanged: (value) {
                      ThemeProvider.setTheme = value;
                  },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

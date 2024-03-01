import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plateform_convertor/provider.dart';
import 'package:provider/provider.dart';

class Ios_add_contact extends StatefulWidget {
  const Ios_add_contact({super.key});

  @override
  State<Ios_add_contact> createState() => _Ios_add_contactState();
}

class _Ios_add_contactState extends State<Ios_add_contact> {
  final List<Widget> _tabs = [
    abc(),
    // iosperson(),

    // const HomeTab(), // see the HomeTab class below
    // const SettingTab() // see the SettingsTab class below
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlatformProvider>(context, listen: true);
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_add_solid)),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2), label: 'CHATS'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'CALLS'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), label: 'SETTINGS'),
        ],
      ),

      // navigationBar: CupertinoNavigationBar(
      //   trailing: CupertinoSwitch(
      //     value: isTheme,
      //     onChanged: (value){
      //       setState(() {
      //         Fluttertoast.showToast(msg: "Android",
      //             toastLength: Toast.LENGTH_LONG,
      //             gravity: ToastGravity.BOTTOM,
      //             fontSize: 20);
      //         Navigator.of(context).pop();
      //       });
      //     },
      //   ),
      // ),

      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context){
            return Center(
              child: _tabs[index],
            );
          },
        );
      },
    );
  }
}
class abc extends StatefulWidget {
  const abc({super.key});

  @override
  State<abc> createState() => _abcState();
}

class _abcState extends State<abc> {
  @override
  Widget build(BuildContext context) {
    return Text("hello");
  }
}


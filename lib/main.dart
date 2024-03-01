import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plateform_convertor/provider.dart';
import 'package:plateform_convertor/setting_screen.dart';
import 'package:provider/provider.dart';
import 'add_contact_screen.dart';
import 'calls_screen.dart';
import 'chats_screen.dart';
import 'ios_add_contact.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> PlatformProvider()),
      ],
      child: Consumer<PlatformProvider>(
        builder: (context,ThemeVar,child){
          return (ThemeVar.isTheme == true)
          ?CupertinoApp(
            theme: CupertinoThemeData(),
            debugShowCheckedModeBanner: false,
            home:Ios_add_contact(),
          )
          :MaterialApp(
            theme:ThemeVar.isDarkTheme== false
            ? ThemeData.dark(useMaterial3: true)
            : ThemeData.light(useMaterial3: true),
            debugShowCheckedModeBanner: false,
            home: MyHomePage(),
          );
        }

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    final  provider = Provider.of<PlatformProvider>(context,listen: true);
    return DefaultTabController(
      length: 4,

      child: Scaffold(
        appBar: AppBar(
          actions: [
            Switch(
                value: provider.getPlatform,
                onChanged: (value){
                  provider.setPlatform = value;
                })
          ],
         // backgroundColor:Colors.purple,
          bottom: TabBar(tabs: [
            Icon(Icons.person_add_alt,size: 28),
            Text('CHATS',style: TextStyle(fontWeight: FontWeight.bold,fontSize:16)),
            Text('CALLS',style: TextStyle(fontWeight: FontWeight.bold,fontSize:16)),
            Text('SETTING',style: TextStyle(fontWeight: FontWeight.bold,fontSize:16)),
          ],),
          title: Text('Platform Converter'),
        ),
        body: TabBarView(
          children: [
            Add_contactData(),
            ChatScreen(),
            Call_Screen(),
            Setting_Screen(),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){},
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}

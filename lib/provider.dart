import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plateform_convertor/modleclass.dart';

class PlatformProvider with ChangeNotifier{
  List<ModelClass> ContactData = [];

  bool isTheme = false;
  set setPlatform(value){
    isTheme = value;
    notifyListeners();
  }
  get getPlatform{
    return isTheme;
  }

  bool isDarkTheme = false;


  set setTheme(value){
    isDarkTheme = value;
    notifyListeners();
  }

  addDataList(ModelClass data)
  {
    ContactData.add(data);
    notifyListeners();
  }


  updateData(ModelClass data,int index)
  {
    ContactData[index] = data;
    notifyListeners();
  }

}

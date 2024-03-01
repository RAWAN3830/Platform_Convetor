import 'dart:io';

class ModelClass
{
  final String? name;
  final String? chat;
  var FormatedTime;
  var FormatedDate;
  final File image;
  final int number;

  ModelClass({
    required this.name,
    required this.chat,
    required this.FormatedTime,
    required this.FormatedDate,
    required this.image,
    required this.number});
}
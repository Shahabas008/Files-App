import 'package:flutter/material.dart';

class CardModel {
  String title;
  BuildContext context;
  Function() navigateto;
  CardModel(this.context, this.navigateto, this.title);
}

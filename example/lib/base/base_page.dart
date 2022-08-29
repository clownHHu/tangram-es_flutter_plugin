import 'package:flutter/cupertino.dart';

abstract class BasePage extends StatelessWidget {
  final String title;
  final String subTitle;

  const BasePage(this.title, this.subTitle);
}

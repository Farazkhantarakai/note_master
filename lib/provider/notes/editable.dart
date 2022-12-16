import 'package:flutter/material.dart';

class Editable extends ChangeNotifier {
  double size = 15;
  int _colorIndex = 0;
  Color get select => _colors[_colorIndex];
  int _cursorColorIndex = 0;
  Color get selectCColor => _cursorTextColors[_cursorColorIndex];
  //a list of colors that will change the cursor and text color
  final List<Color> _cursorTextColors = [
    Colors.black,
    Colors.white,
  ];
  //these color will change the background of note app color
  final List<Color> _colors = [
    Colors.white,
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.deepPurple,
    Colors.indigo,
    Colors.cyan,
    Colors.yellowAccent
  ];
  //this will align text at a particular position
  TextAlign makeCenter = TextAlign.start;
  get verticalCenter => makeCenter;

  void doStart() {
    makeCenter = TextAlign.left;
    notifyListeners();
  }

  void doJustify() {
    makeCenter = TextAlign.justify;
    notifyListeners();
  }

  void increaseSize() {
    if (size < 30) {
      size += 4;
    } else {
      size = 15;
    }
    notifyListeners();
  }

  void decreaseSize() {
    if (size > 15) {
      size -= 2;
    } else {
      size = 15;
    }
    notifyListeners();
  }

  void selectBackGroundColor() {
    if (_colorIndex < _colors.length - 1) {
      _colorIndex++;
    } else {
      _colorIndex = 0;
    }
    _colors[_colorIndex];

    notifyListeners();
  }

  void selectCursorColor() {
    if (_cursorColorIndex < _cursorTextColors.length - 1) {
      _cursorColorIndex++;
    } else {
      _cursorColorIndex = 0;
    }
    _cursorTextColors[_cursorColorIndex];
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class App {
  BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}

class Colors {
  Color mainColor(double opacity) {
    return Color(0xF5B2C70).withOpacity(opacity);
  }
///40+
  Color secondColor(double opacity) {
    return Color(0xc70a0a).withOpacity(opacity);
  }
///30-40
  Color accentColor(double opacity) {
    return Color(0xc75c0a).withOpacity(opacity);
  }
///30-20
  Color mainDarkColor(double opacity) {
    return Color(0xf2cc11).withOpacity(opacity);
  }
  ///20-10
  Color secondDarkColor(double opacity) {
    return Color(0x12c483).withOpacity(opacity);
  }
  ///10 - 0
  Color accentDarkColor(double opacity) {
    return Color(0x12c4b5).withOpacity(opacity);
  }
  ///-0
  Color indicatorColor(double opacity) {
    return Color(0x0ecfe8).withOpacity(opacity);
  }

  Color scaffoldColor(double opacity) {
    //
    return Color(0xFFFFFFFF).withOpacity(opacity);
  }

  Color textColor(double opacity) {
    return Color(0x000000).withOpacity(opacity);
  }

  Color textColorDark(double opacity) {
    return Color(0x000000).withOpacity(opacity);
  }

  Color secondaryHeaderColor(double opacity) {
    return Color(0xFFFFFFFF).withOpacity(opacity);
  }

}

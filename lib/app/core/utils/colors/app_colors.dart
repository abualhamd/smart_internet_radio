import 'package:flutter/material.dart';
import 'custome_material_color.dart';
import 'hex_colors.dart';

abstract class ColorsManager {
  static final Color primary = HexColor('#202053');
  static final MaterialColor primaryMaterial =
      CustomMaterialColor(primary).color;
  static final Color? playBarColor = primaryMaterial[200];
  static const white = Colors.white;
  static const black = Colors.black;
}

import 'package:flutter/material.dart';
import 'custome_material_color.dart';
import 'hex_colors.dart';

abstract class AppColors {
  static final Color primary = HexColor('#202053');
  static final MaterialColor primaryMaterial =
      CustomMaterialColor(primary).color;
  static final Color? playBarColor = primaryMaterial[200];
}

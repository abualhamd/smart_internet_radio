import 'package:flutter/material.dart';

import '../enums.dart';
import '../icons_manager.dart';

extension GetIcon on Categories{
  Widget getIcon(){
    switch (this) {
      case Categories.quran:
        return IconsManager.ctgQuran;
      case Categories.news:
        return IconsManager.ctgNews;
      case Categories.music:
        return IconsManager.ctgMusic;
      case Categories.sports:
        return IconsManager.ctgSports;
    }
  }
}
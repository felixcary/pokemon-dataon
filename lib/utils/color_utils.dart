import 'package:flutter/material.dart';
import 'package:pokemon/styles/colors.dart';

class ColorUtil {
  static Color getTypeColor(String type) {
    switch (type) {
      case 'normal':
        return AppColors.normal;
      case 'water':
        return AppColors.water;
      case 'dragon':
        return AppColors.dragon;
      case 'electric':
        return AppColors.electric;
      case 'fairy':
        return AppColors.fairy;
      case 'ghost':
        return AppColors.ghost;
      case 'fire':
        return AppColors.fire;
      case 'grass':
        return AppColors.grass;
      case 'bug':
        return AppColors.bug;
      case 'fighting':
        return AppColors.fighting;
      case 'dark':
        return AppColors.dark;
      case 'steel':
        return AppColors.steel;
      case 'ground':
        return AppColors.ground;
      case 'psychic':
        return AppColors.psychic;
      case 'rock':
        return AppColors.rock;
      case 'poison':
        return AppColors.poison;
      case 'flying':
        return AppColors.flying;
      default:
        return AppColors.normal;
    }
  }
}

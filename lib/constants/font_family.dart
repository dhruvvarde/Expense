import 'package:flutter/material.dart';
import './colors.dart';


class FontFamily{
  FontFamily._();

  static const robotoMedium = 'Roboto Medium';


  static const TextStyle accentColorStyle = TextStyle(
      fontFamily: FontFamily.robotoMedium,
      color: AppColors.accentColor,
      fontSize: 16);

  static const TextStyle greyDate = TextStyle(
      fontFamily: FontFamily.robotoMedium,
      color: AppColors.greyLight,
      fontSize: 13);
  static const TextStyle greyTitleMedium = TextStyle(
      fontFamily: FontFamily.robotoMedium,
      color: AppColors.greyMedium,
      fontSize: 14);
  static const TextStyle greyTitle = TextStyle(
      fontFamily: FontFamily.robotoMedium,
      color: AppColors.greyMedium,
      fontSize: 16);
  static const TextStyle greyTitleLarge = TextStyle(
      fontFamily: FontFamily.robotoMedium,
      color: AppColors.grey,
      fontSize: 20);
  static const TextStyle blueTitleMedium = TextStyle(
      fontFamily: FontFamily.robotoMedium,
      color: AppColors.primaryColor,
      fontSize: 16);
  static const TextStyle whiteTitleMedium = TextStyle(
      fontFamily: FontFamily.robotoMedium,
      color: AppColors.white,
      fontSize: 17);

}
import 'package:flutter/material.dart';

class Images {
  Images._();
  static const String images = "assets/images";
  static const String svgs = "assets/svgs";
  // images
  static const String background = "$images/bg.png";
  static const String splash1 = "$images/splash1.png";
  static const String splash2 = "$images/splash2.png";
  static const String splash3 = "$images/splash3.png";
  static const String logo = "$images/logo.png";
  static const String loginBg = "$images/login_start_bg.png";
  static const String onProfile = '$images/profile_back.png';
  static const String onSpaghetti = "$images/spaghetti.png";
  static const String onNoodles = "$images/noodles.png";
  static const String onChicken = "$images/chicken.png";
  static const String onTaco = "$images/taco.png";
  static const String onMeat = "$images/meat.png";
  static const String onCook = "$images/cook.png";
  static const String onSeafood = "$images/seafood.png";
  static const String onSalad = "$images/salad.png";
  static const String onCenterFood = "$images/centerFood.png";

  static const String onVeggies = "$images/veggies.png";
  static const String onEggs = "$images/eggs.png";
  static const String onSushi = "$images/sushi.png";
  static const String onOctopus = "$images/octopus.png";
  static const String onApple = "$images/apple.png";
  static const String onBacon = "$images/bacon.png";







  // svgs
 static const String google = "$svgs/google.svg";
  static const String apple = "$svgs/apple.svg";
}

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF3FB4B1);
  static const Color primary22Opacity = Color(0xFFd5eeee);
}

class Fonts {
  Fonts._();

  static const dmSans = "DMSans";
  static const gordita = "Gordita";
}

class TextStyles {
  TextStyles._();
  static const TextStyle black = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle blackItalic = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle bold = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle boldItalic = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle semiBold = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle semiBoldItalic = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle medium = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle mediumItalic = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle regular = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle regularItalic = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle light = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle lightItalic = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle thin = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle thinItalic = TextStyle(
    fontFamily: Fonts.dmSans,
    fontWeight: FontWeight.w100,
    fontStyle: FontStyle.italic,
  );
}

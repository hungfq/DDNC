import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class Themes {
  static final TextStyle headerTextStyle = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static final TextStyle labelTabBarTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static final TextStyle unselectedLabelTabBarTextStyle =
      GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static final TextStyle titleItemListTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: 0.05,
  );
  static final TextStyle contentItemListTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static final TextStyle drawerMenuItemTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: 8,
    letterSpacing: 0.4,
  );
  static final TextStyle selectedBottomNavTextStyle = GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.4,
  );
  static final TextStyle unSelectedBottomNavTextStyle = GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
  );
  static final TextStyle locationCellTextStyle = GoogleFonts.montserrat(
    fontSize: 6,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
  );
  static final TextStyle locationDescriptionDetailTextStyle =
      GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
  );
  static final TextStyle locationZoneOverviewTitleTextStyle =
      GoogleFonts.montserrat(
    fontSize: 6,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
  );
  static final TextStyle locationZoneOverviewSubtitleTextStyle =
      GoogleFonts.montserrat(
    fontSize: 4,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
  );

  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.montserrat(
        fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.montserrat(
        fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3:
        GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.montserrat(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5:
        GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.montserrat(
        fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.0),
    subtitle1: GoogleFonts.montserrat(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.montserrat(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.montserrat(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.montserrat(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.montserrat(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.montserrat(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.montserrat(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  static const ColorScheme _colorSchemeLight = ColorScheme.light(
    primary: AppColors.lightPrimaryColor,
    secondary: AppColors.lightSecondaryColor,
    surface: AppColors.lightSurfaceColor,
    background: AppColors.lightBackgroundColor,
    error: AppColors.lightErrorColor,
    onPrimary: AppColors.lightOnPrimaryColor,
    onSecondary: AppColors.lightOnSecondaryColor,
    onSurface: AppColors.lightOnSurfaceColor,
    onError: AppColors.lightOnErrorColor,
    onBackground: AppColors.lightOnBackgroundColor,
    brightness: Brightness.light,
  );

  static const ColorScheme _colorSchemeDark = ColorScheme.light(
    primary: AppColors.darkPrimaryColor,
    secondary: AppColors.darkSecondaryColor,
    surface: AppColors.darkSurfaceColor,
    background: AppColors.darkBackgroundColor,
    error: AppColors.darkErrorColor,
    onPrimary: AppColors.darkOnPrimaryColor,
    onSecondary: AppColors.darkOnSecondaryColor,
    onSurface: AppColors.darkOnSurfaceColor,
    onError: AppColors.darkOnErrorColor,
    onBackground: AppColors.darkOnBackgroundColor,
    brightness: Brightness.dark,
  );

  static final ThemeData lightTheme = ThemeData(
    focusColor: AppColors.lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: AppColors.lightPrimaryColor,
      iconTheme: IconThemeData(color: AppColors.lightOnSurfaceColor),
      elevation: Dimens.appbarElevation,
      shadowColor: AppColors.lightDividerColor,
    ),
    shadowColor: AppColors.lightDividerColor,
    platform: TargetPlatform.iOS,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.lightPrimaryColor,
      unselectedLabelColor: AppColors.disabledBackgroundColor,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
              color: AppColors.lightPrimaryColor,
              width: Dimens.tabBarIndicatorWeight)),
      labelPadding: EdgeInsets.zero,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.largeComponentRadius),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    errorColor: AppColors.lightErrorColor,
    primaryColor: AppColors.lightPrimaryColor,
    dividerTheme: const DividerThemeData(
        color: AppColors.lightDividerColor,
        thickness: Dimens.smallComponentStrokeWidth),
    backgroundColor: AppColors.lightBackgroundColor,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          _textTheme.button!,
        ),
        elevation: MaterialStateProperty.all<double>(
          Dimens.defaultElevationButton,
        ),
        splashFactory: NoSplash.splashFactory,
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return const BorderSide(
              color: AppColors.lightSecondaryColor,
              width: Dimens.outlinedButtonStrokeWidth,
            );
          } else if (states.contains(MaterialState.disabled)) {
            return const BorderSide(
              color: AppColors.lightOnBackgroundColor,
              width: Dimens.outlinedButtonStrokeWidth,
            );
          }
          return const BorderSide(
            color: AppColors.lightSecondaryColor,
            width: Dimens.outlinedButtonStrokeWidth,
          ); // Use
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.lightSecondaryColor;
            } else if (states.contains(MaterialState.disabled)) {
              return AppColors.lightOnBackgroundColor;
            }
            return AppColors
                .lightSecondaryColor; // Use the component's default.
          },
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          _textTheme.button!,
        ),
        elevation: MaterialStateProperty.all<double>(
          Dimens.defaultElevationButton,
        ),
        splashFactory: NoSplash.splashFactory,
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.lightSecondaryColor;
            } else if (states.contains(MaterialState.disabled)) {
              return AppColors.lightOnBackgroundColor;
            }
            return AppColors
                .lightSecondaryColor; // Use the component's default.
          },
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          AppColors.lightOnSecondaryColor,
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.buttonRadius),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: AppColors.lightOnSecondaryColor,
    ),
    splashFactory: NoSplash.splashFactory,
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      fillColor: AppColors.lightSurfaceColor,
      filled: true,
      border: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightPrimaryColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.lightErrorColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      hintStyle: _textTheme.bodyText1!.apply(
        color: AppColors.lightOnBackgroundColor,
      ),
      labelStyle: _textTheme.bodyText1!.apply(
        color: AppColors.lightOnBackgroundColor,
      ),
    ),
    indicatorColor: AppColors.lightPrimaryColor,
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.lightSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.mediumComponentRadius),
        side: const BorderSide(
          color: AppColors.lightStrokeColor,
          width: Dimens.mediumComponentStrokeWidth,
        ),
      ),
    ),
    textTheme: _textTheme,
    primaryTextTheme: _textTheme,
    colorScheme: _colorSchemeLight,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.lightPrimaryColor),
  );
  static final ThemeData darkTheme = ThemeData(
    focusColor: AppColors.darkPrimaryColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: AppColors.darkPrimaryColor,
      iconTheme: IconThemeData(color: AppColors.darkOnSurfaceColor),
      elevation: Dimens.appbarElevation,
    ),
    platform: TargetPlatform.iOS,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.darkOnSurfaceColor,
      unselectedLabelColor: AppColors.darkOnSurfaceColor,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
        color: AppColors.darkPrimaryColor,
        width: Dimens.tabBarIndicatorWeight,
      )),
      labelPadding: EdgeInsets.zero,
    ),
    errorColor: AppColors.darkErrorColor,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.largeComponentRadius),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColors.darkPrimaryColor,
    dividerTheme: const DividerThemeData(
      color: AppColors.darkDividerColor,
      thickness: Dimens.smallComponentStrokeWidth,
    ),
    backgroundColor: AppColors.darkBackgroundColor,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          _textTheme.button!,
        ),
        elevation: MaterialStateProperty.all<double>(
          Dimens.defaultElevationButton,
        ),
        splashFactory: NoSplash.splashFactory,
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return const BorderSide(
              color: AppColors.darkSecondaryColor,
              width: Dimens.outlinedButtonStrokeWidth,
            );
          } else if (states.contains(MaterialState.disabled)) {
            return const BorderSide(
              color: AppColors.darkOnBackgroundColor,
              width: Dimens.outlinedButtonStrokeWidth,
            );
          }
          return const BorderSide(
            color: AppColors.darkSecondaryColor,
            width: Dimens.outlinedButtonStrokeWidth,
          ); // Use
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.darkSecondaryColor;
            } else if (states.contains(MaterialState.disabled)) {
              return AppColors.darkOnBackgroundColor;
            }
            return AppColors.darkSecondaryColor; // Use the component's default.
          },
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonRadius),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          _textTheme.button!,
        ),
        elevation: MaterialStateProperty.all<double>(
          Dimens.defaultElevationButton,
        ),
        splashFactory: NoSplash.splashFactory,
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.darkSecondaryColor;
            } else if (states.contains(MaterialState.disabled)) {
              return AppColors.darkOnBackgroundColor;
            }
            return AppColors.darkSecondaryColor; // Use the component's default.
          },
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          AppColors.darkOnSecondaryColor,
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.buttonRadius),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: AppColors.darkOnSecondaryColor,
    ),
    splashFactory: NoSplash.splashFactory,
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      fillColor: AppColors.darkSurfaceColor,
      filled: true,
      border: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkPrimaryColor),
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.darkErrorColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(Dimens.textInputRadius)),
      ),
      hintStyle: _textTheme.bodyText1!.apply(
        color: AppColors.darkOnBackgroundColor,
      ),
    ),
    indicatorColor: AppColors.darkPrimaryColor,
    cardTheme: CardTheme(
      color: AppColors.darkSurfaceColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.mediumComponentRadius),
        side: const BorderSide(
          color: AppColors.darkStrokeColor,
          width: Dimens.mediumComponentStrokeWidth,
        ),
      ),
    ),
    textTheme: _textTheme,
    primaryTextTheme: _textTheme,
    colorScheme: _colorSchemeDark,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.darkPrimaryColor),
  );
}

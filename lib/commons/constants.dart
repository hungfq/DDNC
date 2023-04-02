import 'package:flutter/animation.dart';

class Constants {
  // Env name variable
  static const appNameKey = "APP_NAME";
  static const appIdKey = "APP_ID";
  static const databaseVersionKey = "DATABASE_VERSION";
  static const apiGatewayKey = "API_MOBILE_GATEWAY";
  static const verCodeKey = "VER_CODE";
  static const verNameKey = "VER_NAME";
  static const environmentKey = "ENVIRONMENT";

  // Locale
  static const vietnameseLangLocale = "vi";
  static const englishLangLocale = "en";
  static const defaultLocale = englishLangLocale;

  // default config;
  static const defaultCurrency = "VND";
  static const defaultTimeZone = "Asia/Ho_Chi_Minh";
  static const defaultDateFormat = "dd/MM/yyyy";
  static const defaultTimeFormat = "HH:mm";

  // config key
  static const dateFormatKey = "DAT";
  static const timeFormatKey = "TIM";
  static const timeZoneKey = "TMZ";

  // Duration
  static const int snackBarDuration = 3000; //s
  static const int animationDuration = 200; // ms
  static const int secondaryAnimationDuration = 400; // ms
  static const int delayTime = 300; // ms
  static const int splashDelayTime = 1000; // ms
  static const scannerDelayTime = Duration(milliseconds: 100); // ms
  static const filterDelayTime = Duration(milliseconds: 1500); //ms
  static const throttleDuration = Duration(milliseconds: 100);

  // Animation
  static const defaultCurve = Curves.ease;

  // Image loading
  static const damagedReceiptImageMaxCount = 4;
  static const itemImageMaxCount = 4;
  static const imageQuality = 40; // unit: %
  static const resizedImageWidth = 300.0; // NW-1041
  static const retryTimes = 3;
  static const timeRetry = Duration(milliseconds: 500);

  // Format
  static const standardDateFormat = "yyyy-MM-dd";
  static const standardTimeFormat = "HH:mm:ss";
  static const currencyFormat = "#,##0.00";
  static const currencyDecimalDigits = 2; // ###.00
  static const serverDateFormat = "yyyy/MM/dd";
  static const uiDateFormat = "yyyy/MM/dd";
  static const nameImageDateFormat = "ddMMyyhhmmssSSS";
  static const batchDateFormat = "yyMMdd";

  // Network
  static const int connectionTimeout = 50000; // ms
  static const int serverErrorStatusCode = 500;
  static const int invalidTokenStatusCode = 402;
  static const int errorMaxLines = 5;
  static const int unknownId = -1;
  static const int itemPerPage = 10;
  static const int uploadImageRetryTimes = 3;

  // Pattern
  static const String intNumberPattern = "^[0-9]+\$";

  // QR code / barcode
  static const defaultPrefixQrCode = "SN:";
  static const defaultSerialDelimiter = ";";

  // Number
  static const receivingDoubleAsFixed = 0;

  // special characters
  static const dotChar = '\u0387';

  // Others
  static const maxElementSuggestion = 50;
  static const minCharSuggestion = 3;
  static const minCharLocationSuggestion = 1;
  static const palletPlaceholder = "[%s]-XXXX-XXXX";
  static const avatarMaxSize = 10; // 10 MB
  static const genderMale = "MALE";
  static const genderFemale = "FEMALE";
  static const yearPickerRange = 20;
  static const defaultBatch = "NA";
  static const scrollProvisionalIndex = 3;
  static const dropdownPlaceholder = "--- %s ---";
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home_menu_button_HOME {
    return Intl.message(
      'Home',
      name: 'home_menu_button_HOME',
      desc: '',
      args: [],
    );
  }

  /// `Meals`
  String get home_menu_button_COST {
    return Intl.message(
      'Meals',
      name: 'home_menu_button_COST',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get home_menu_button_PROFILE {
    return Intl.message(
      'Profile',
      name: 'home_menu_button_PROFILE',
      desc: '',
      args: [],
    );
  }

  /// `Created at `
  String get list_item_label_CREATED {
    return Intl.message(
      'Created at ',
      name: 'list_item_label_CREATED',
      desc: '',
      args: [],
    );
  }

  /// `Usage: `
  String get list_item_label_USAGE {
    return Intl.message(
      'Usage: ',
      name: 'list_item_label_USAGE',
      desc: '',
      args: [],
    );
  }

  /// `Cost: `
  String get list_item_label_COST {
    return Intl.message(
      'Cost: ',
      name: 'list_item_label_COST',
      desc: '',
      args: [],
    );
  }

  /// `Ingredient`
  String get category_label_INGREDIENT {
    return Intl.message(
      'Ingredient',
      name: 'category_label_INGREDIENT',
      desc: '',
      args: [],
    );
  }

  /// `Meal Prep`
  String get category_label_MEAL_PREP {
    return Intl.message(
      'Meal Prep',
      name: 'category_label_MEAL_PREP',
      desc: '',
      args: [],
    );
  }

  /// `Gift`
  String get category_label_GIFT {
    return Intl.message(
      'Gift',
      name: 'category_label_GIFT',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category_label {
    return Intl.message(
      'Category',
      name: 'category_label',
      desc: '',
      args: [],
    );
  }

  /// `Please add your ingredients`
  String get add_ingredient_label_text {
    return Intl.message(
      'Please add your ingredients',
      name: 'add_ingredient_label_text',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

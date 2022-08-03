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

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message(
      'Light Mode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to delete`
  String get wouldYouLikeDelete {
    return Intl.message(
      'Would you like to delete',
      name: 'wouldYouLikeDelete',
      desc: '',
      args: [],
    );
  }

  /// `Bread and Bread Spreads`
  String get breadAndBreadSpreads {
    return Intl.message(
      'Bread and Bread Spreads',
      name: 'breadAndBreadSpreads',
      desc: '',
      args: [],
    );
  }

  /// `Care`
  String get careProducts {
    return Intl.message(
      'Care',
      name: 'careProducts',
      desc: '',
      args: [],
    );
  }

  /// `Cleaning`
  String get cleaningProducts {
    return Intl.message(
      'Cleaning',
      name: 'cleaningProducts',
      desc: '',
      args: [],
    );
  }

  /// `Dairy`
  String get dairy {
    return Intl.message(
      'Dairy',
      name: 'dairy',
      desc: '',
      args: [],
    );
  }

  /// `Dry goods`
  String get dryGoods {
    return Intl.message(
      'Dry goods',
      name: 'dryGoods',
      desc: '',
      args: [],
    );
  }

  /// `Frozen`
  String get frozen {
    return Intl.message(
      'Frozen',
      name: 'frozen',
      desc: '',
      args: [],
    );
  }

  /// `Meat and Fish`
  String get meatAndFish {
    return Intl.message(
      'Meat and Fish',
      name: 'meatAndFish',
      desc: '',
      args: [],
    );
  }

  /// `Pet shop`
  String get petShop {
    return Intl.message(
      'Pet shop',
      name: 'petShop',
      desc: '',
      args: [],
    );
  }

  /// `Snacks`
  String get snacks {
    return Intl.message(
      'Snacks',
      name: 'snacks',
      desc: '',
      args: [],
    );
  }

  /// `Vegetables and Fruits`
  String get vegetablesAndFruits {
    return Intl.message(
      'Vegetables and Fruits',
      name: 'vegetablesAndFruits',
      desc: '',
      args: [],
    );
  }

  /// `Add new item`
  String get addNewItem {
    return Intl.message(
      'Add new item',
      name: 'addNewItem',
      desc: '',
      args: [],
    );
  }

  /// `Create new list`
  String get createList {
    return Intl.message(
      'Create new list',
      name: 'createList',
      desc: '',
      args: [],
    );
  }

  /// `Deletar item`
  String get deleteItem {
    return Intl.message(
      'Deletar item',
      name: 'deleteItem',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Name is invalid`
  String get invalidName {
    return Intl.message(
      'Name is invalid',
      name: 'invalidName',
      desc: '',
      args: [],
    );
  }

  /// `Owner is invalid`
  String get invalidOwner {
    return Intl.message(
      'Owner is invalid',
      name: 'invalidOwner',
      desc: '',
      args: [],
    );
  }

  /// `At least one previous or next item needs to be informed`
  String get oneItemNeedToBeInformed {
    return Intl.message(
      'At least one previous or next item needs to be informed',
      name: 'oneItemNeedToBeInformed',
      desc: '',
      args: [],
    );
  }

  /// `Error to get lists`
  String get errorToGetLists {
    return Intl.message(
      'Error to get lists',
      name: 'errorToGetLists',
      desc: '',
      args: [],
    );
  }

  /// `Error to create list`
  String get errorToCreateList {
    return Intl.message(
      'Error to create list',
      name: 'errorToCreateList',
      desc: '',
      args: [],
    );
  }

  /// `Error to delete list`
  String get errorToDeleteList {
    return Intl.message(
      'Error to delete list',
      name: 'errorToDeleteList',
      desc: '',
      args: [],
    );
  }

  /// `Error to update list`
  String get errorToUpdateList {
    return Intl.message(
      'Error to update list',
      name: 'errorToUpdateList',
      desc: '',
      args: [],
    );
  }

  /// `Error to get items`
  String get errorToGetItems {
    return Intl.message(
      'Error to get items',
      name: 'errorToGetItems',
      desc: '',
      args: [],
    );
  }

  /// `Error to add item`
  String get errorToAddItem {
    return Intl.message(
      'Error to add item',
      name: 'errorToAddItem',
      desc: '',
      args: [],
    );
  }

  /// `Error to delete item`
  String get errorToDeleteItem {
    return Intl.message(
      'Error to delete item',
      name: 'errorToDeleteItem',
      desc: '',
      args: [],
    );
  }

  /// `Error to update item`
  String get errorToUpdateItem {
    return Intl.message(
      'Error to update item',
      name: 'errorToUpdateItem',
      desc: '',
      args: [],
    );
  }

  /// `Error to reorder items`
  String get errorToReorderItems {
    return Intl.message(
      'Error to reorder items',
      name: 'errorToReorderItems',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
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

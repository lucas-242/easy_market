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

  /// `Do you really want to logout?`
  String get logoutConfirmation {
    return Intl.message(
      'Do you really want to logout?',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
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

  /// `Grocery Lists`
  String get groceryLists {
    return Intl.message(
      'Grocery Lists',
      name: 'groceryLists',
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

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
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

  /// `Type your new password.`
  String get typeNewPassword {
    return Intl.message(
      'Type your new password.',
      name: 'typeNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get checkEmail {
    return Intl.message(
      'Check your email',
      name: 'checkEmail',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password reset`
  String get confirmPasswordReset {
    return Intl.message(
      'Confirm password reset',
      name: 'confirmPasswordReset',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a link to reset your password`
  String get resetPasswordLinkSent {
    return Intl.message(
      'We have sent a link to reset your password',
      name: 'resetPasswordLinkSent',
      desc: '',
      args: [],
    );
  }

  /// `Open email app`
  String get openEmailApp {
    return Intl.message(
      'Open email app',
      name: 'openEmailApp',
      desc: '',
      args: [],
    );
  }

  /// `Did not receive the email? Check your spam filter, or `
  String get didNotReceiveEmail {
    return Intl.message(
      'Did not receive the email? Check your spam filter, or ',
      name: 'didNotReceiveEmail',
      desc: '',
      args: [],
    );
  }

  /// `try another email address`
  String get tryAnotherEmail {
    return Intl.message(
      'try another email address',
      name: 'tryAnotherEmail',
      desc: '',
      args: [],
    );
  }

  /// `Skip, I'll confirm later`
  String get confirmLater {
    return Intl.message(
      'Skip, I\'ll confirm later',
      name: 'confirmLater',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email associated with your account and we will send an email with a link that you will use to reset your password.`
  String get sendPasswordInstructions1 {
    return Intl.message(
      'Enter the email associated with your account and we will send an email with a link that you will use to reset your password.',
      name: 'sendPasswordInstructions1',
      desc: '',
      args: [],
    );
  }

  /// `If you won't receive an email in a few minutes, check your spam folder.`
  String get sendPasswordInstructions2 {
    return Intl.message(
      'If you won\'t receive an email in a few minutes, check your spam folder.',
      name: 'sendPasswordInstructions2',
      desc: '',
      args: [],
    );
  }

  /// `Send email`
  String get sendEmail {
    return Intl.message(
      'Send email',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Invalid shopping list`
  String get invalidShoppingList {
    return Intl.message(
      'Invalid shopping list',
      name: 'invalidShoppingList',
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

  /// `{property} is invalid`
  String invalidProperty(String property) {
    return Intl.message(
      '$property is invalid',
      name: 'invalidProperty',
      desc: '',
      args: [property],
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

  /// `Error to get logged user`
  String get errorToGetLoggedUser {
    return Intl.message(
      'Error to get logged user',
      name: 'errorToGetLoggedUser',
      desc: '',
      args: [],
    );
  }

  /// `There is no logged user`
  String get thereIsNoUser {
    return Intl.message(
      'There is no logged user',
      name: 'thereIsNoUser',
      desc: '',
      args: [],
    );
  }

  /// `Error to reset password`
  String get errorToResetPassword {
    return Intl.message(
      'Error to reset password',
      name: 'errorToResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Error to sign up`
  String get errorToSignUp {
    return Intl.message(
      'Error to sign up',
      name: 'errorToSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Error to sign in`
  String get errorToSignIn {
    return Intl.message(
      'Error to sign in',
      name: 'errorToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Error to logout`
  String get errorToLogout {
    return Intl.message(
      'Error to logout',
      name: 'errorToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Code was not retrieved automatically`
  String get codeNotRetrieved {
    return Intl.message(
      'Code was not retrieved automatically',
      name: 'codeNotRetrieved',
      desc: '',
      args: [],
    );
  }

  /// `Error to save user data`
  String get errorToSaveUserData {
    return Intl.message(
      'Error to save user data',
      name: 'errorToSaveUserData',
      desc: '',
      args: [],
    );
  }

  /// `An unknown exception occurred`
  String get unknowError {
    return Intl.message(
      'An unknown exception occurred',
      name: 'unknowError',
      desc: '',
      args: [],
    );
  }

  /// `The link has expired`
  String get linkHasExpired {
    return Intl.message(
      'The link has expired',
      name: 'linkHasExpired',
      desc: '',
      args: [],
    );
  }

  /// `The link has already been used`
  String get linkHasBeenUsed {
    return Intl.message(
      'The link has already been used',
      name: 'linkHasBeenUsed',
      desc: '',
      args: [],
    );
  }

  /// `Password is too weak. Please, try a different one`
  String get passwordIsWeak {
    return Intl.message(
      'Password is too weak. Please, try a different one',
      name: 'passwordIsWeak',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid or badly formatted`
  String get emailIsInvalid {
    return Intl.message(
      'Email is invalid or badly formatted',
      name: 'emailIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `This user has been disabled. Please contact support for help`
  String get userHasBeenDisabled {
    return Intl.message(
      'This user has been disabled. Please contact support for help',
      name: 'userHasBeenDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Email was not found, please create an account`
  String get emailWasNotFound {
    return Intl.message(
      'Email was not found, please create an account',
      name: 'emailWasNotFound',
      desc: '',
      args: [],
    );
  }

  /// `There is already an account with this credential`
  String get thereIsAnotherAccount {
    return Intl.message(
      'There is already an account with this credential',
      name: 'thereIsAnotherAccount',
      desc: '',
      args: [],
    );
  }

  /// `The credential is invalid`
  String get credentialIsInvalid {
    return Intl.message(
      'The credential is invalid',
      name: 'credentialIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The verification code entered is invalid`
  String get verificationCodeIsInvalid {
    return Intl.message(
      'The verification code entered is invalid',
      name: 'verificationCodeIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `The verification ID entered is invalid`
  String get verificationIdIsInvalid {
    return Intl.message(
      'The verification ID entered is invalid',
      name: 'verificationIdIsInvalid',
      desc: '',
      args: [],
    );
  }

  /// `You can not create an account with this method. Please try another account or contact support for help`
  String get cantCreateAccountWithMethod {
    return Intl.message(
      'You can not create an account with this method. Please try another account or contact support for help',
      name: 'cantCreateAccountWithMethod',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password`
  String get incorrectEmailOrPassword {
    return Intl.message(
      'Incorrect email or password',
      name: 'incorrectEmailOrPassword',
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

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

  /// `Welcome to WhatsApp`
  String get title {
    return Intl.message(
      'Welcome to WhatsApp',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Read our Privacy Policy . Tap"Agree and continue" to accept the Terms of Service `
  String get policy {
    return Intl.message(
      'Read our Privacy Policy . Tap"Agree and continue" to accept the Terms of Service ',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `AGREE AND CONTINUE`
  String get AcceptButton {
    return Intl.message(
      'AGREE AND CONTINUE',
      name: 'AcceptButton',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get Mylanguage {
    return Intl.message(
      'English',
      name: 'Mylanguage',
      desc: '',
      args: [],
    );
  }

  /// `App language`
  String get AppLanguage {
    return Intl.message(
      'App language',
      name: 'AppLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get Registertitle {
    return Intl.message(
      'Enter your phone number',
      name: 'Registertitle',
      desc: '',
      args: [],
    );
  }

  /// `NEXT`
  String get Next {
    return Intl.message(
      'NEXT',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Choose a country`
  String get Choosecountry {
    return Intl.message(
      'Choose a country',
      name: 'Choosecountry',
      desc: '',
      args: [],
    );
  }

  /// `you entered the phone number :`
  String get Alerttitle {
    return Intl.message(
      'you entered the phone number :',
      name: 'Alerttitle',
      desc: '',
      args: [],
    );
  }

  /// `Is this OK , or would you like to edit the number ?`
  String get Alertcontent {
    return Intl.message(
      'Is this OK , or would you like to edit the number ?',
      name: 'Alertcontent',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get okbutton {
    return Intl.message(
      'OK',
      name: 'okbutton',
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

  /// `CANCEL`
  String get cancel {
    return Intl.message(
      'CANCEL',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `EDIT`
  String get editbutton {
    return Intl.message(
      'EDIT',
      name: 'editbutton',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter the phone number`
  String get enternumber {
    return Intl.message(
      'Please Enter the phone number',
      name: 'enternumber',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get Warning {
    return Intl.message(
      'Warning',
      name: 'Warning',
      desc: '',
      args: [],
    );
  }

  /// `Verifing your number`
  String get numbercheck {
    return Intl.message(
      'Verifing your number',
      name: 'numbercheck',
      desc: '',
      args: [],
    );
  }

  /// `we wait untill your recive the SMS `
  String get waitcheck {
    return Intl.message(
      'we wait untill your recive the SMS ',
      name: 'waitcheck',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code which from 6 numbers`
  String get EnterCode {
    return Intl.message(
      'Enter the code which from 6 numbers',
      name: 'EnterCode',
      desc: '',
      args: [],
    );
  }

  /// `profile info`
  String get profileinfo {
    return Intl.message(
      'profile info',
      name: 'profileinfo',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide your name and an optional profile photo`
  String get profiledata {
    return Intl.message(
      'Please Provide your name and an optional profile photo',
      name: 'profiledata',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get Enteryourname {
    return Intl.message(
      'Enter your name',
      name: 'Enteryourname',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get WhatsApp {
    return Intl.message(
      'WhatsApp',
      name: 'WhatsApp',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get Chats {
    return Intl.message(
      'Chats',
      name: 'Chats',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get Status {
    return Intl.message(
      'Status',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// `Calls`
  String get Calls {
    return Intl.message(
      'Calls',
      name: 'Calls',
      desc: '',
      args: [],
    );
  }

  /// `New group`
  String get Newgroup {
    return Intl.message(
      'New group',
      name: 'Newgroup',
      desc: '',
      args: [],
    );
  }

  /// `New broadcast`
  String get Newbroadcast {
    return Intl.message(
      'New broadcast',
      name: 'Newbroadcast',
      desc: '',
      args: [],
    );
  }

  /// `Linked devices`
  String get Linkeddevices {
    return Intl.message(
      'Linked devices',
      name: 'Linkeddevices',
      desc: '',
      args: [],
    );
  }

  /// `Starred messages`
  String get Starredmessages {
    return Intl.message(
      'Starred messages',
      name: 'Starredmessages',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `This is not your username or pin .This name will be visible to your WhatsApp contacts`
  String get userNameguide {
    return Intl.message(
      'This is not your username or pin .This name will be visible to your WhatsApp contacts',
      name: 'userNameguide',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `ProfilePhoto`
  String get profilephoto {
    return Intl.message(
      'ProfilePhoto',
      name: 'profilephoto',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Remove profile photo?`
  String get RemoveProfpic {
    return Intl.message(
      'Remove profile photo?',
      name: 'RemoveProfpic',
      desc: '',
      args: [],
    );
  }

  /// `Select contact`
  String get Selectcontact {
    return Intl.message(
      'Select contact',
      name: 'Selectcontact',
      desc: '',
      args: [],
    );
  }

  /// `New contact`
  String get Newcontact {
    return Intl.message(
      'New contact',
      name: 'Newcontact',
      desc: '',
      args: [],
    );
  }

  /// `New community`
  String get Newcommunity {
    return Intl.message(
      'New community',
      name: 'Newcommunity',
      desc: '',
      args: [],
    );
  }

  /// `View Contact`
  String get viewcontact {
    return Intl.message(
      'View Contact',
      name: 'viewcontact',
      desc: '',
      args: [],
    );
  }

  /// `online`
  String get online {
    return Intl.message(
      'online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `offline`
  String get offline {
    return Intl.message(
      'offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Invite a friend`
  String get inviteafriend {
    return Intl.message(
      'Invite a friend',
      name: 'inviteafriend',
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
      Locale.fromSubtags(languageCode: 'ar'),
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

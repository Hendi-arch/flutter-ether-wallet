import 'dart:io';
import 'dart:math';
// ignore: implementation_imports, import_of_legacy_library_into_null_safe
import 'package:convert/src/hex.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show Utf8Encoder;
// ignore: import_of_legacy_library_into_null_safe
import 'package:crypto/crypto.dart' show md5;
import 'package:web3dart/web3dart.dart';

class UtilityService {
  Future<DateTime?> pickDate(BuildContext context) async {
    var _result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        lastDate: DateTime(2030, 12, 31),
        firstDate: DateTime(2000, 01, 01));

    return _result;
  }

  void deleteSystemPath(String dirPath) {
    final dir = Directory(dirPath);
    dir.deleteSync(recursive: true);
  }

  String encryptor(String input) {
    final _encodeValue = new Utf8Encoder().convert(input);
    final _digest = md5.convert(_encodeValue);
    return hex.encode(_digest.bytes);
  }

  int generateNumber() {
    final rInstance = new Random.secure();
    var _result = rInstance.nextDouble() * 100000000;
    while (_result < 10000000) {
      _result *= 10;
    }
    return _result.toInt();
  }

  Future<bool?> checkConnections() async {
    bool? connection;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        connection = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      connection = false;
    }
    return connection;
  }

  String conditionalEndPointPrefix() {
    if (Platform.isAndroid) return '?';

    return '';
  }

  String formatEthAddress(String address) =>
      '${address.substring(0, 6)}...${address.substring(address.length - 6, address.length)}';

  String formatEthAmount({
    BigInt? amount,
    EtherUnit fromUnit = EtherUnit.wei,
    EtherUnit toUnit = EtherUnit.ether,
  }) {
    if (amount == null) {
      return '-';
    }

    return EtherAmount.fromUnitAndValue(fromUnit, amount).getValueInUnit(toUnit).toString();
  }

  String mnemonicNormalise(String mnemonic) => mnemonicWords(mnemonic).join(' ');

  List<String> mnemonicWords(String mnemonic) =>
      mnemonic.split(' ').where((item) => item.trim().isNotEmpty).map((item) => item.trim()).toList();

  bool validateMnemonic(String mnemonic) => mnemonicWords(mnemonic).length == 12;
}

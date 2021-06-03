import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/core/services/configuration_service.dart';
import 'package:hex/hex.dart';
import 'package:convert/convert.dart';
import 'package:web3dart/credentials.dart';

class AddressService {
  // services
  final ConfigurationService _configurationService = locator<ConfigurationService>();

  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  String entropyToMnemonic(String entropyMnemonic) {
    return bip39.entropyToMnemonic(entropyMnemonic);
  }

  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeedHex(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(hex.decode(seed), masterSecret: 'Bitcoin seed');
    final privateKey = HEX.encode(master.key);
    print('private: $privateKey');
    return privateKey;
  }

  Future<EthereumAddress> getPublicAddress(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);

    final address = await private.extractAddress();
    print('address: $address');
    return address;
  }

  Future<bool> setupFromMnemonic(String mnemonic) async {
    final cryptMnemonic = bip39.mnemonicToEntropy(mnemonic);
    final privateKey = await getPrivateKey(mnemonic);

    _configurationService.setMnemonic(cryptMnemonic);
    _configurationService.setPrivateKey(privateKey);
    _configurationService.setupDone(true);
    return true;
  }

  Future<bool> setupFromPrivateKey(String privateKey) async {
    _configurationService.setMnemonic(null);
    _configurationService.setPrivateKey(privateKey);
    _configurationService.setupDone(true);
    return true;
  }
}

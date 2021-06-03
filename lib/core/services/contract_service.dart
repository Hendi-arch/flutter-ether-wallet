import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_smart_contract/core/api/api.dart';
import 'package:flutter_smart_contract/app/app.locator.dart';

typedef TransferEvent = void Function(
  EthereumAddress from,
  EthereumAddress to,
  BigInt value,
);

// typedef ApprovalEvent = void Function(
//   EthereumAddress tokenOwner,
//   EthereumAddress spender,
//   BigInt value,
// );

abstract class ERC20StandardInterface {
  Future<String?> send(String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent? onTransfer, Function(Object exeception)? onError});
  Future<BigInt> getTokenBalance(EthereumAddress from);
  Future<BigInt> getTotalSupply();
}

class ContractService implements ERC20StandardInterface {
  final Api api = locator<Api>();

  late final Web3Client client;
  late final DeployedContract deployedContract;
  static const String contractAddress = '0x8f2863F0E2f37368CdA9a9c03Fe51D2c5F7285f8';

  ContractEvent _transferEvent() => deployedContract.event('Transfer');
  // ContractEvent _approvalEvent() => contract.event('Approval');

  ContractFunction _totalSupplyFunction() => deployedContract.function('totalSupply');
  ContractFunction _balanceOfFunction() => deployedContract.function('balanceOf');
  ContractFunction _transferFunction() => deployedContract.function('transfer');
  // ContractFunction _allowanceFunction() => contract.function('allowance');
  // ContractFunction _approveFunction() => contract.function('approve');
  // ContractFunction _transferFromFunction() => contract.function('transferFrom');

  @override
  Future<String?> send(String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent? onTransfer, Function(Object exeception)? onError}) async {
    final credentials = await getCredentials(privateKey);
    final from = await credentials.extractAddress();
    final networkId = await client.getNetworkId();

    StreamSubscription? event;
    // Workaround once sendTransacton doesn't return a Promise containing confirmation / receipt
    if (onTransfer != null) {
      event = listenTransfer((from, to, value) async {
        onTransfer(from, to, value);
        await event?.cancel();
      }, take: 1);
    }

    try {
      final transactionId = await client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: deployedContract,
          function: _transferFunction(),
          parameters: [receiver, amount],
          from: from,
        ),
        chainId: networkId,
      );
      print('transact started $transactionId');
      return transactionId;
    } catch (ex) {
      if (onError != null) {
        onError(ex);
      }
      return null;
    }
  }

  @override
  Future<BigInt> getTokenBalance(EthereumAddress from) async {
    final response = await client.call(
      contract: deployedContract,
      function: _balanceOfFunction(),
      params: [from],
    );

    return response.first as BigInt;
  }

  @override
  Future<BigInt> getTotalSupply() async {
    final response = await client.call(
      contract: deployedContract,
      function: _totalSupplyFunction(),
      params: [],
    );

    return response.first as BigInt;
  }

  Future initialSetup() async {
    deployedContract = await ContractParser.fromAssets('assets/artifacts/TestSystemContract.json', contractAddress);

    client = Web3Client(api.rpcUrl, LoggingClient(Client()), socketConnector: () {
      return IOWebSocketChannel.connect(api.wsUrl).cast<String>();
    });
  }

  Future<Credentials> getCredentials(String privateKey) => client.credentialsFromPrivateKey(privateKey);

  Future<EtherAmount> getEthBalance(EthereumAddress from) async {
    return client.getBalance(from);
  }

  StreamSubscription listenTransfer(TransferEvent onTransfer, {int? take}) {
    var events = client.events(FilterOptions.events(
      contract: deployedContract,
      event: _transferEvent(),
    ));

    if (take != null) {
      events = events.take(take);
    }

    return events.listen((event) {
      if (event.topics == null || event.data == null) {
        return;
      }

      final decoded = _transferEvent().decodeResults(event.topics!, event.data!);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;

      print('$from}');
      print('$to}');
      print('$value}');

      onTransfer(from, to, value);
    });
  }

  Future<void> dispose() async {
    await client.dispose();
  }
}

class ContractParser {
  static Future<DeployedContract> fromAssets(String path, String contractAddress) async {
    final contractJson = jsonDecode(await rootBundle.loadString(path));

    return DeployedContract(
        ContractAbi.fromJson(jsonEncode(contractJson['abi']), contractJson['contractName'] as String),
        EthereumAddress.fromHex(contractAddress));
  }
}

class LoggingClient extends BaseClient {
  final Client _inner;

  LoggingClient(this._inner);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (request is Request) {
      print('sending ${request.url} with ${request.body}');
    } else {
      print('sending ${request.url}');
    }

    final response = await _inner.send(request);
    final read = await Response.fromStream(response);

    print('response:\n${read.body}');

    return StreamedResponse(Stream.fromIterable([read.bodyBytes]), response.statusCode);
  }
}

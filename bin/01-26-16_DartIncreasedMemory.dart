import "dart:isolate";
import "dart:math";

import "package:dslink/dslink.dart";
import "package:dslink/io.dart";

import "package:dsbroker/broker.dart";

const int MAX_NUMBER = 50000;

main() async {
  int port = await getRandomSocketPort();
  DsHttpServer server = await startBrokerServer(port, persist: false);
  TokenNode token = TokenGroupNode.createTrustedToken(
    "rng",
    server.nodeProvider
  );

  await Isolate.spawn(linkHandler, {
    "port": port,
    "token": token.token
  });
}

const List<String> names = const [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z"
];

linkHandler(Map<String, dynamic> params) async {
  int port = params["port"];
  String token = params["token"];

  Map<String, dynamic> nodes = {};

  for (String name in names) {
    nodes[name] = {
      r"$name": "Number ${name.toUpperCase()}",
      r"$type": "number"
    };
  }

  var link = new LinkProvider([
    "--broker=http://127.0.0.1:${port}/conn",
    "--token=${token}"
  ], "RNG-", nodes: nodes, isRequester: true, isResponder: true);

  Random random = new Random();
  List<SimpleNode> nodez = [];
  for (String name in names) {
    nodez.add(link["/${name}"]);
  }
  Scheduler.every(Interval.ONE_MILLISECOND, () {
    for (SimpleNode n in nodez) {
      n.updateValue(random.nextInt(MAX_NUMBER));
    }
  });

  link.connect();
  Requester requester = await link.onRequesterReady;

  for (String name in names) {
    String path = "/downstream/RNG/${name}";
    requester.subscribe(path, (ValueUpdate update) {});
  }
}

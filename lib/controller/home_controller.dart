// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_connections/nearby_connections.dart';

class HomeController extends GetxController {
  final RxString userName = 'userName'.obs;
  RxList<String> discoveredEndpoints = <String>[].obs;
  RxList<String> connectedEndpoints = <String>[].obs;
  RxString rereceivedMessage = ''.obs;
  RxString receivedMessage = ''.obs;
  final Strategy strategy = Strategy.P2P_CLUSTER;
  TextEditingController priceController = TextEditingController();

  void startDiscovery() {
    Nearby().startDiscovery(
      userName.value,
      strategy,
      onEndpointFound: (id, name, serviceId) {
        discoveredEndpoints.add(id);
      },
      onEndpointLost: (id) {
        discoveredEndpoints.remove(id);
      },
    );
  }

  void startAdvertising() {
    Nearby().startAdvertising(
      userName.value,
      strategy,
      onConnectionInitiated: (id, info) {
        Nearby().acceptConnection(id, onPayLoadRecieved: (endid, payload) {
          receivedMessage.value =
              String.fromCharCodes(payload.bytes as Iterable<int>);
          if (receivedMessage.value == "پرداخت لغو شد") {
            Get.showSnackbar(
              const GetSnackBar(
                title: "پرداخت توسط مخاطب لغو گردید",
              ),
            );
          } else if (receivedMessage.value == "پرداخت با موفقیت انجام شد") {
            Get.showSnackbar(
              const GetSnackBar(
                title: "پرداخت با موفقیت انجام شد",
              ),
            );
          } else if (receivedMessage.value == "پرداخت ناموفق بود") {
            Get.showSnackbar(
              const GetSnackBar(
                title: "پرداخت ناموفق بود",
              ),
            );
          } else if (receivedMessage.value == "پرداخت در حال انجام ....") {
            Get.showSnackbar(
                const GetSnackBar(title: "پرداخت در حال انجام ...."));
          } else
            Get.dialog(Dialog(
              child: SizedBox(
                height: Get.height * 0.35,
                width: Get.width,
                child: Column(
                  children: [
                    Text("پرداخت ${receivedMessage.value} را قبول میکنید؟"),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.showSnackbar(
                                const GetSnackBar(
                                  title: "پرداخت لغو شد",
                                ),
                              );
                              sendMessage(endid, "c");
                            },
                            child: const Text("لغو")),
                        ElevatedButton(
                            onPressed: () {
                              sendMessage(endid, "l");
                              Get.dialog(Dialog(
                                child: SizedBox(
                                  height: Get.height * .4,
                                  width: Get.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            sendMessage(endid,
                                                "o");
                                          },
                                          child: const Text("پرداخت موفق")),
                                      ElevatedButton(
                                          onPressed: () {
                                            sendMessage(
                                                endid, "f");
                                          },
                                          child: const Text("پرداخت ناموفق"))
                                    ],
                                  ),
                                ),
                              ));
                            },
                            child: const Text("تایید"))
                      ],
                    )
                  ],
                ),
              ),
            ));
        });
      },
      onConnectionResult: (id, status) {
        if (status == Status.CONNECTED) {
          connectedEndpoints.add(id);
        } else {
          connectedEndpoints.remove(id);
        }
      },
      onDisconnected: (id) {
        connectedEndpoints.remove(id);
      },
    );
  }

  void sendMessage(String endpointId, String message) {
    Nearby()
        .sendBytesPayload(endpointId, Uint8List.fromList(message.codeUnits));
  }
}

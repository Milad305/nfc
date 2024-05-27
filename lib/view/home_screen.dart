// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nearby_connections/nearby_connections.dart';

import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پرداخت من'),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //card
                  /*  Row(
                      children: [
                        const Text(
                          "5859 8311 4905 9379",
                          style: TextStyle(fontSize: 17),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("انتخاب کارت"),
                        ),
                      ],
                    ),
                  */
                  const SizedBox(
                    height: 7,
                  ),
                  //price
                  Row(
                    children: [
                      const Text(
                        "مبلغ قابل پرداخت:",
                        style: TextStyle(fontSize: 17),
                      ),
                      Spacer(),
                      Container(
                          height: 45,
                          width: 200,
                          child: TextField(
                            controller: controller.priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: "مبلغ"),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //search
                  Row(
                    children: [
                      const Text(
                        "نمایش دستگاه ها:",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: controller.startDiscovery,
                        child: const Text('جستجو'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: controller.startAdvertising,
                        child: const Text('دریافت'),
                      ),
                      /* ElevatedButton(
                        onPressed: () {
                          controller.startAdvertising;
                          print("start descovery");
                          // controller.startDiscovery;
                        },
                        child: const Text(
                          "Advertis",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),*/

                      /*  ElevatedButton(
                        onPressed: () {
                          controller.startDiscovery;
                          print("start descovery");

                          ;
                        },
                        child: const Text(
                          "descovery",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),*/
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: Get.height * 0.5,
                      width: Get.width,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)),
                      child: controller.discoveredEndpoints.isNotEmpty
                          ? Column(
                              children: controller.discoveredEndpoints
                                  .map((endpoint) {
                                return ListTile(
                                  title: Text('نام دستگاه: $endpoint'),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      Nearby().requestConnection(
                                        controller.userName.value,
                                        endpoint,
                                        onConnectionInitiated: (id, info) {
                                          Nearby().acceptConnection(id,
                                              onPayLoadRecieved:
                                                  (endid, payload) {
                                              controller.rereceivedMessage.value =
                                                String.fromCharCodes(payload
                                                    .bytes as Iterable<int>);
                                            print(controller
                                                .rereceivedMessage.value);
                                                     if (controller.rereceivedMessage.value == "c") {
            Get.showSnackbar(
  const GetSnackBar(
    title: "پرداخت توسط مخاطب لغو گردید",
    message: "Message content here",
    duration: Duration(seconds: 3), // Optional duration
  ),
);
          } else if (controller.rereceivedMessage.value == "o") {
            Get.showSnackbar(
              const GetSnackBar(
                
                title: "پرداخت با موفقیت انجام شد",
                
                message: "Message content here",
              ),
              
            );
          } else if (controller.rereceivedMessage.value == "f") {
            Get.showSnackbar(
              const GetSnackBar(
                
                title: "پرداخت ناموفق بود",
                message: "Message content here",
              ),
              
              
            );
          } else if (controller.rereceivedMessage.value == "l") {
            Get.showSnackbar(
                const GetSnackBar(
                  
                  title: "پرداخت در حال انجام ....",
                                  message: "Message content here",
                  ),);
                

          }
                                          });
                                          
                                        },
                                        onConnectionResult: (id, status) {
                                          if (status == Status.CONNECTED) {
                                            controller.connectedEndpoints
                                                .add(id);
                                            controller.sendMessage(
                                                endpoint,
                                                controller
                                                    .priceController.text);
                                          } else {
                                            controller.connectedEndpoints
                                                .remove(id);

                                            Get.showSnackbar(const GetSnackBar(
                                              
                                              title:
                                                  "درخواست ارسال توسط کاربر رد شد",
                                                  message: "Message content here",
                                                  
                                            ));
                                          }
                                        },
                                        onDisconnected: (id) {
                                          controller.connectedEndpoints
                                              .remove(id);
                                          Get.showSnackbar(GetSnackBar(
                                            
                                            title:
                                                "درخواست ارسال توسط کاربر رد شد",
                                                message: "Message content here",
                                                
                                          ));
                                        },
                                      );
                                    },
                                    child: const Text('ارسالی'),
                                  ),
                                );
                              }).toList(),
                            )
                          : const Center(
                              child: Text("دستگاهی یافت نشد"),
                            )),

                  ///////////////////////////////////////////////////////////////////////////////////////////////
                  /*    ElevatedButton(
                    onPressed: controller.startDiscovery,
                    child: const Text('Start Discovery'),
                  ),
                  ElevatedButton(
                    onPressed: controller.startAdvertising,
                    child: const Text('Start Advertising'),
                  ),*/
                  /* Obx(() {
                    return Column(
                      children: [
                       if (controller.discoveredEndpoints.isNotEmpty)
                          Column(
                            children:
                                controller.discoveredEndpoints.map((endpoint) {
                              return ListTile(
                                title: Text('Discovered Endpoint: $endpoint'),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    Nearby().requestConnection(
                                      controller.userName.value,
                                      endpoint,
                                      onConnectionInitiated: (id, info) {
                                        Nearby().acceptConnection(id,
                                            onPayLoadRecieved:
                                                (endid, payload) {
                                          /*  controller.receivedMessage.value =
                                              String.fromCharCodes(payload.bytes
                                                  as Iterable<int>); */
                                          print(
                                              controller.receivedMessage.value);
                                        });
                                      },
                                      onConnectionResult: (id, status) {
                                        if (status == Status.CONNECTED) {
                                          controller.connectedEndpoints.add(id);
                                        } else {
                                          controller.connectedEndpoints
                                              .remove(id);
                                        }
                                      },
                                      onDisconnected: (id) {
                                        controller.connectedEndpoints
                                            .remove(id);
                                      },
                                    );
                                  },
                                  child: const Text('Connect'),
                                ),
                              );
                            }).toList(),
                          ),
                       if (controller.connectedEndpoints.isNotEmpty)
                          Column(
                            children:
                                controller.connectedEndpoints.map((endpoint) {
                              return ListTile(
                                title: Text('Connected to Endpoint: $endpoint'),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        TextEditingController
                                            messageController =
                                            TextEditingController();
                                        return AlertDialog(
                                          title: const Text('Send Message'),
                                          content: TextField(
                                            controller: messageController,
                                            decoration: const InputDecoration(
                                                hintText: 'Enter your message'),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                controller.sendMessage(endpoint,
                                                    messageController.text);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Send'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Send Message'),
                                ),
                              );
                            }).toList(),
                          ),
                        if (controller.receivedMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Received Message: ${controller.receivedMessage.value}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                     ],
                    );
                  })*/
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

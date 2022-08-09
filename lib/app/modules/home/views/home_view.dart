import 'package:assignment/services/responsive_size.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Menu'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.kh),
                  child: Column(
                    children: [
                      Visibility(
                        visible: controller.catModelLocal.isNotEmpty,
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text("Popular Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.kh)),
                                trailing: SizedBox(
                                  width: 15.w,
                                  child: Row(
                                    children: [
                                      Flexible(child: Text(controller.catModelLocal.length < 3 ? controller.catModelLocal.length.toString() : 3.toString())),
                                      Flexible(
                                        child: IconButton(
                                            icon: Icon(controller.isPopularView.value ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right_outlined),
                                            onPressed: () => controller.updateIndexLocal()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.isPopularView.value,
                                child: Container(
                                    width: 100.w,
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(8.0),
                                      shrinkWrap: true,
                                      primary: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.catModelLocal.length < 3 ? controller.catModelLocal.length : 3,
                                      itemBuilder: (context, index) => ListTile(
                                        title: Container(
                                          width: 100.w,
                                          child: Row(
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(minWidth: 10.w, maxWidth: 50.w),
                                                child: Text(
                                                  controller.catModelLocal[index].name.toString(),
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.kw,
                                              ),
                                              index == 0
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20.kh),
                                                        color: Colors.red,
                                                        boxShadow: [
                                                          BoxShadow(color: Colors.grey, spreadRadius: 1),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 2.kh, horizontal: 4.kw),
                                                        child: Text(
                                                          "Best seller",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 10.kh),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        subtitle: Text(
                                          "\$ " + controller.catModelLocal[index].price.toString(),
                                          style: TextStyle(fontWeight: FontWeight.normal),
                                        ),
                                        trailing: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.deepOrangeAccent,
                                              style: BorderStyle.solid,
                                              width: 1.0,
                                            ),
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          child: CartStepperInt(
                                            count: controller.catModelLocal[index].count,
                                            size: 30,
                                            elevation: 0,
                                            style: CartStepperStyle.fromTheme(Theme.of(context)).copyWith(
                                              activeForegroundColor: Colors.deepOrangeAccent,
                                              activeBackgroundColor: Colors.white,
                                              deActiveForegroundColor: Colors.deepOrangeAccent,
                                            ),
                                            didChangeCount: (count) {
                                              controller.updateCountLocal(index, count, controller.catModelLocal[index].price!);
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.all(8.kh),
                        shrinkWrap: true,
                        primary: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.catModel.length,
                        itemBuilder: (context, index) => Card(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(controller.catModel[index].name.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.kh)),
                                trailing: SizedBox(
                                  width: 15.w,
                                  child: Row(
                                    children: [
                                      Flexible(child: Text(controller.catModel[index].cat!.length.toString())),
                                      Flexible(
                                        child: IconButton(
                                            icon: Icon(controller.catModel[index].isView! ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right_outlined),
                                            onPressed: () {
                                              controller.isLoading.value = true;
                                              if (controller.catModel[index].isView == true) {
                                                controller.catModel[index].isView = false;
                                              } else {
                                                controller.catModel[index].isView = true;
                                              }

                                              controller.isLoading.value = false;
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.catModel[index].isView!,
                                child: Container(
                                    width: 100.w,
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(8.0),
                                      shrinkWrap: true,
                                      primary: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.catModel[index].cat!.length,
                                      itemBuilder: (context, catIndex) => ListTile(
                                        title: Text(
                                          controller.catModel[index].cat![catIndex].name.toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          "\$ " + controller.catModel[index].cat![catIndex].price.toString(),
                                          style: TextStyle(fontWeight: FontWeight.normal),
                                        ),
                                        trailing: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.deepOrangeAccent,
                                              style: BorderStyle.solid,
                                              width: 1.0,
                                            ),
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          child: CartStepperInt(
                                            count: controller.catModel[index].cat![catIndex].count,
                                            size: 30,
                                            elevation: 0,
                                            style: CartStepperStyle.fromTheme(Theme.of(context)).copyWith(
                                              activeForegroundColor: Colors.deepOrangeAccent,
                                              activeBackgroundColor: Colors.white,
                                              deActiveForegroundColor: Colors.deepOrangeAccent,
                                            ),
                                            didChangeCount: (count) {
                                              controller.updateCount(index, catIndex, count, controller.catModel[index].cat![catIndex].price!);
                                            },
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.kh,
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(16.kh),
        child: Container(
            width: 100.w,
            height: 50.kh,
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh), side: BorderSide(color: Colors.deepOrangeAccent)))),
              onPressed: () {
                controller.saveOrder();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Place Order",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Obx(() => Text("\$" + controller.mPrice.value.toString(), style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            )),
      ),
    );
  }
}

import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nectar/app_config.dart';
import 'package:nectar/main.dart';
import 'package:nectar/utility/app_color.dart';
import 'package:nectar/view/account_screen/invoice/controller/invoice_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utility/app_const.dart';
class OrderInvoiceList extends StatelessWidget {
   OrderInvoiceList({super.key});

  final InvoiceController controller = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        title: Text("Mes Factures"),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: InkWell(
            onTap: (){
              showCustomDateRangePicker(
                context,
                dismissible: true,
                minimumDate: DateTime.now().subtract(const Duration(days: 2000)),
                maximumDate: DateTime.now().add(const Duration(days: 30)),
                // endDate: DateTime(2025, 2, 2),
                // startDate: DateTime(2025, 1, 1),
                backgroundColor: Colors.white,
                primaryColor: AppColors.bgGreen,
                onApplyClick: (start, end) {
                  controller.startDate.value = DateFormat('yyyy-MM-dd').format(start);
                  controller.endDate.value = DateFormat('yyyy-MM-dd').format(end);

                  //get product
                  controller.getMyInvoice();
                },
                onCancelClick: () {
                  controller.startDate.value = "";
                  controller.endDate.value = "";
                  },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0,2)
                  )
                ]
              ),
              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() {
                      return Column(
                        children: [
                          Text("Form",
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600
                            ),
                          ),
                          Text( "${controller.startDate.value.isEmpty ?"Select start date" : controller.startDate.value }" ),
                        ],
                      );
                    }
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Obx(() {
                    return Column(
                      children: [
                        Text("To",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600
                          ),
                        ),
                        Text( "${controller.endDate.value.isEmpty ?"Select end date" : controller.endDate.value }" ),
                      ],
                    );                  }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),


      body: Padding(
        padding: EdgeInsets.all(10),
        child: Obx((){
          if(controller.isLoading.value){
            return Center(
              child: CircularProgressIndicator.adaptive()
            );
          }else if(controller.invoiceOrderList!.isEmpty){
            return Center(
              child: Text("No order found"),
            );
          }else{
            return ListView.builder(
              itemCount: controller.invoiceOrderList.value!.length,
              itemBuilder: (_, index){
                var data = controller.invoiceOrderList.value[index];


                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        spreadRadius: 1, blurRadius: 2
                      )
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order ID",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12
                            ),
                          ),
                          Text("${data.id}"),
                        ],
                      ),
                      Container(
                        width: 1, height: 30, color: Colors.grey,
                      ),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("DATE DE LIVRAISON",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12
                          ),
                         ),
                         Text("${newDateFormate(data.deliveryDate!)}"),
                       ],
                     ),
                      Container(
                        width: 1, height: 30, color: Colors.grey,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("STATUS",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12
                            ),
                          ),
                          Text("${data.orderStatus}"),
                        ],
                      ),
                      Container(
                        width: 1, height: 30, color: Colors.grey,
                      ),

                      IconButton(
                        onPressed: ()async{
                          var token = sharedPreferences!.getString("token");
                          //print("token -- ${token}");
                          //print("${AppConfig.INVOICE_PDF_URL}""${data.id}?token=${token}");
                          await launchUrl(Uri.parse("${AppConfig.INVOICE_PDF_URL}""${data.id}?token=${token}"));
                        },
                        icon: Icon(Icons.print_outlined, color: AppColors.mainColor,),
                      )

                    ],
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}



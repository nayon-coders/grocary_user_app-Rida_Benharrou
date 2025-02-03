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
        title: const Text("Mes Factures"),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(onPressed: ()=>Get.back(), icon:const Icon(Icons.arrow_back_ios)),
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
                  controller.startDate.value = DateFormat('dd/MM/yyyy').format(start);
                  controller.endDate.value = DateFormat('dd/MM/yyyy').format(end);

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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() {
                      return Column(
                        children: [
                          const Text("Depuis le",
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600
                            ),
                          ),
                          Text( "${controller.startDate.value.isEmpty ?"Sélectionnez la date de début" : controller.startDate.value }",
                              style:const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400
                          ),
                          ),
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
                        const Text("Jusqu'au",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600
                          ),
                        ),
                        Text( "${controller.endDate.value.isEmpty ?"Sélectionnez la date de fin" : controller.endDate.value }",style:const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400
                        ), ),
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
        padding: const EdgeInsets.all(10),
        child: Obx((){
          if(controller.isLoading.value){
            return const Center(
              child: CircularProgressIndicator.adaptive()
            );
          }else if(controller.invoiceOrderList!.isEmpty){
            return const Center(
              child: Text("Aucune facture"),
            );
          }else{
            return ListView.builder(
              itemCount: controller.invoiceOrderList.value!.length,
              itemBuilder: (_, index){
                var data = controller.invoiceOrderList.value[index];


                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                          const Text("Order ID",
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
                         const Text("DATE DE LIVRAISON",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12
                          ),
                         ),
                         Text(newDateFormate(data.deliveryDate!)),
                       ],
                     ),
                      Container(
                        width: 1, height: 30, color: Colors.grey,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("STATUS",
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



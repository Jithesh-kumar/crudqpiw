import 'dart:io' show Platform;
import 'package:crud_new/data/crudmodel/crudmodel.dart';
import 'package:crud_new/data/data.dart';
import 'package:crud_new/pages/create_cust.dart';
import 'package:crud_new/widgets/delete.dart';
//import 'package:flutter/foundation.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final Map<String, dynamic>? customerData;

  CustomWidget({super.key, this.customerData});

  final isAndroid = Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await CrudDB.instance.displayCust();
    });
    return Material(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 0),
            child: SizedBox(
              height: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                height: isAndroid ? 400 : 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Display customer data here
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: CrudDB.instance.crudListNotifier,
                        builder: (context, List<Crudmodel> newcustomer, _) {
                          return ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            children: [
                              for (final customer
                                  in CrudDB.instance.crudListNotifier.value)
                                Card(
                                  elevation: 5,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${customer.fName} ${customer.lName}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    // Handle the edit action here
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateCustomer(
                                                          initialData:
                                                              customerData,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.edit_note),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    // Handle the delete action here
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return DeleteBottomSheet();
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(Icons
                                                      .delete_sweep_outlined),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text('Date of Birth: ${customer.dob}'),
                                        const SizedBox(height: 5),
                                        Text('Email: ${customer.email}'),
                                        const SizedBox(height: 5),
                                        Text('Phone Number: ${customer.phone}'),
                                        const SizedBox(height: 5),
                                        Text(
                                            'Bank Account Number: ${customer.accNum}'),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

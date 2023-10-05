import 'dart:io' show Platform;
import 'package:crud_new/pages/create_cust.dart';
import 'package:crud_new/widgets/delete.dart';
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final Map<String, dynamic>? customerData;
  final isAndroid = Platform.isAndroid;

  CustomWidget({this.customerData});

  @override
  Widget build(BuildContext context) {
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
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateCustomer(
                                    initialData: customerData,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit_note),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return DeleteBottomSheet();
                                },
                              );
                            },
                            icon: const Icon(Icons.delete_sweep_outlined),
                          ),
                        ],
                      ),
                    ),
                    // Display customer data here
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        children: [
                          Text(
                            'Name: ${customerData?['First Name'] ?? ''} ${customerData?['Last Name'] ?? ''}',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Date of Birth: ${customerData?['Date of Birth'] ?? ''}',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Email: ${customerData?['Email'] ?? ''}',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Phone Number: ${customerData?['Phone Number'] ?? ''}',
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Bank Account Number: ${customerData?['Bank Account Number'] ?? ''}',
                          ),
                        ],
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

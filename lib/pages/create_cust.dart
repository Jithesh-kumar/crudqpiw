//import 'dart:developer';
import 'dart:io' show Platform;

import 'package:crud_new/data/crudmodel/crudmodel.dart';
import 'package:crud_new/data/data.dart';
//import 'package:crud_new/pages/view_cust.dart';
//import 'package:crud_new/pages/view_cust.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CreateCustomer extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const CreateCustomer({Key? key, this.initialData}) : super(key: key);

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

final isAndroid = Platform.isAndroid;
final _formKey = GlobalKey<FormState>();

class _CreateCustomerState extends State<CreateCustomer> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _debitCardController = TextEditingController();
  @override
  void initState() {
    super.initState();

    if (widget.initialData != null) {
      _firstNameController.text = widget.initialData!['First Name'] ?? '';
      _lastNameController.text = widget.initialData!['Last Name'] ?? '';
      _dateOfBirthController.text = widget.initialData!['Date of Birth'] ?? '';
      _emailController.text = widget.initialData!['Email'] ?? '';
      _phoneNumberController.text = widget.initialData!['Phone Number'] ?? '';
      _debitCardController.text =
          widget.initialData!['Bank Account Number'] ?? '';
    }
  }

  void _clearFields() {
    setState(() {
      _firstNameController.clear();
      _lastNameController.clear();
      _dateOfBirthController.clear();
      _emailController.clear();
      _phoneNumberController.clear();
      _debitCardController.clear();
    });
  }

  void _createOrUpdateCustomer() {
    final customer = {
      'First Name': _firstNameController.text.trim(),
      'Last Name': _lastNameController.text.trim(),
      'Date of Birth': _dateOfBirthController.text.trim(),
      'Email': _emailController.text.trim(),
      'Phone Number': _phoneNumberController.text.trim(),
      'Bank Account Number': _debitCardController.text.trim(),
    };

    if (widget.initialData != null) {
      Navigator.of(context).pop();
      print('Updating customer: $customer');
    } else {
      print('Creating customer: $customer');
    }
  }

  Future<void> saveCust() async {
    final fName = _firstNameController.text;
    final lName = _lastNameController.text;
    final email = _emailController.text;
    final dob = _dateOfBirthController.text;
    final phone = _phoneNumberController.text;
    final accNum = _debitCardController.text;
    final _newCust = Crudmodel.create(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        fName: fName,
        lName: lName,
        email: email,
        dob: dob,
        phone: phone,
        accNum: accNum);

    final newCust = await CrudDB().createCust(_newCust);
    if (newCust != null) {
      Navigator.of(context).pop();
      print('Created customer');
    } else {
      print("Error while saveing customer");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: isAndroid ? 30 : 50),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Back',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(isAndroid ? 10 : 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isAndroid ? 160 : 200),
                          child: Text(
                            widget.initialData != null
                                ? 'Edit Customer'
                                : 'Create Customer',
                            style: GoogleFonts.roboto(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isAndroid ? 280 : 315),
                          child: const Text('First Name'),
                        ),
                        SizedBox(
                          width: 450,
                          height: 65,
                          child: Padding(
                            padding: EdgeInsets.all(isAndroid ? 10 : 10),
                            child: TextFormField(
                                controller: _firstNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.1),
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter first name';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isAndroid ? 280 : 315),
                          child: const Text('Last Name'),
                        ),
                        SizedBox(
                          width: 450,
                          height: 65,
                          child: Padding(
                            padding: EdgeInsets.all(isAndroid ? 10 : 10),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                  labelText: 'LastName',
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.1),
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.5))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isAndroid ? 270 : 305),
                          child: const Text('Date of Birth'),
                        ),
                        SizedBox(
                          width: 450,
                          height: 65,
                          child: Padding(
                            padding: EdgeInsets.all(isAndroid ? 10 : 10),
                            child: TextField(
                              controller: _dateOfBirthController,
                              // keyboardType: TextInputType.number,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly
                              // ],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.calendar_month),
                                labelText: '15-09-2023',
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.1),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isAndroid ? 315 : 352),
                          child: const Text('Email'),
                        ),
                        SizedBox(
                          width: 450,
                          height: 65,
                          child: Padding(
                            padding: EdgeInsets.all(isAndroid ? 10 : 10),
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.mail_outline_rounded),
                                  labelText: 'example@gmail.com',
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.1),
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.5))),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isAndroid ? 260 : 290),
                          child: const Text('Phone Number'),
                        ),
                        SizedBox(
                          width: 450,
                          height: 65,
                          child: Padding(
                            padding: EdgeInsets.all(isAndroid ? 4 : 3),
                            child: IntlPhoneField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: _phoneNumberController,
                              flagsButtonPadding: const EdgeInsets.all(6),
                              dropdownIconPosition: IconPosition.trailing,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.1),
                                ),
                              ),
                              initialCountryCode: 'IN',
                              onChanged: (phone) {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(right: isAndroid ? 200 : 240),
                          child: const Text('Bank Account Number'),
                        ),
                        SizedBox(
                          width: 450,
                          height: 65,
                          child: Padding(
                            padding: EdgeInsets.all(isAndroid ? 10 : 10),
                            child: TextField(
                              controller: _debitCardController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.card_membership),
                                labelText: '1-23-45-67-890',
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.1),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(isAndroid ? 8.0 : 8.0),
                              child: SizedBox(
                                width: 390,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    saveCust();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 130, 118, 242)
                                            .withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    widget.initialData != null
                                        ? 'Update'
                                        : 'Create',
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: _clearFields,
                              child: const Text('Discard'),
                            ),
                            SizedBox(
                              height: isAndroid ? 0 : 40,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

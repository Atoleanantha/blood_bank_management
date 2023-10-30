
import 'package:blood_bank_management/Utils/Utils.dart';
import 'package:blood_bank_management/screens/HomeScreen.dart';
import 'package:blood_bank_management/services/database/DBServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/RegistrationModel.dart';

class AddDonorEntry extends StatefulWidget {
  AddDonorEntry({super.key, required this.currentDonor});
  RetriveDonorModel currentDonor;

  @override
  State<AddDonorEntry> createState() => _AddDonorEntryState();
}

class _AddDonorEntryState extends State<AddDonorEntry> {
  TextEditingController dateInput = TextEditingController();
  bool isloading = false;
  late bool isInserted;
  @override
  void initState() {
    dateInput.text = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    super.initState();
  }

  void chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd')
          .format(pickedDate); // Format the DateTime to a string.
      setState(() {
        dateInput.text =
            formattedDate; // Set the formatted date in the TextEditingController.
      });
    }
  }

  void addDonorEntry() async {

    setState(() {
      isloading = true;
    });
    isInserted =
        await DBServices().addEntryToDonorHistory(widget.currentDonor, dateInput.text);
    setState(() {
      isloading = false;
    });

    if (isInserted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Entry Added")));
      Navigator.pop(context);

    } else {
      Utils().toastMassage("Failed to add. Retry again!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donor entry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Full Name : ${widget.currentDonor.name}",
              style: TextStyle(fontSize: 18, overflow: TextOverflow.visible),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Addhar Number : ${widget.currentDonor.addharNo}",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Donation Date : ",
                  style: TextStyle(),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: dateInput,
                        decoration: const InputDecoration(
                          hintText: "Click here to select date",
                          suffixIcon:
                              Icon(Icons.calendar_today), //icon of text field
                        ),
                        readOnly: true,
                        onTap: chooseDate,
                      ),
                      const Text(
                        "To change Click here*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Center(child: isloading ? CircularProgressIndicator() : SizedBox()),
            Expanded(child: SizedBox()),
            Center(
                child: isloading
                    ? SizedBox()
                    : ElevatedButton(
                        onPressed: () {
                          addDonorEntry();
                        },
                        child: const Text("Submit")))
          ],
        ),
      ),
    );
  }
}

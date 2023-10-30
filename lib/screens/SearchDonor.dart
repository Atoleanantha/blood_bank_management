import 'package:blood_bank_management/model/RegistrationModel.dart';
import 'package:blood_bank_management/services/database/DBServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ViewDetails.dart';

class SearchDonor extends StatefulWidget {
  const SearchDonor({super.key});

  @override
  State<SearchDonor> createState() => _SearchDonorState();
}

class _SearchDonorState extends State<SearchDonor> {
  bool isSearching = false;

  RetriveDonorModel? donor;
  String message = "Search Donor by addhar id";
  TextEditingController addharId = TextEditingController();
  @override
  void initState() {
    donor = null;
    super.initState();
  }

  void getDonor(String addharId) async {
    setState(() {
      isSearching=true;
    });
    RetriveDonorModel? result = await DBServices().getDonorByAddharId(addharId);
    if (result != null) {
      setState(() {
        donor = result;
      });
    } else {
      // Handle the case where the result is null (document not found).
      // You can set a default value or handle it accordingly.
      setState(() {
        message = 'Donor not found for addharId: $addharId';
      });
      isSearching = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              ElevatedButton(
                child: const Text(
                  "Search",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (addharId.text.isNotEmpty) {
                    isSearching = true;
                    getDonor(addharId.text.toString());

                    isSearching = false;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter valid addhar id")));
                  }
                },
              ),
            ],
            centerTitle: true,
            title: Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(),
                    // borderRadius: BorderRadius.circular(30)
                ),
                child: TextFormField(
                  controller: addharId,
                  keyboardType: TextInputType.number,
                  decoration:const InputDecoration(
                    hintText: "Enter AddharId",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) async {},
                ))),
        body: donor != null
            ? donorTile(donor!)
            : Center(
                child: isSearching
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        backgroundColor: Colors.grey,
                      )
                    :  Text(message),
              ));
  }

  Widget donorTile(RetriveDonorModel donor) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 30,
        child: Icon(
          Icons.person,
          size: 50,
        ),
      ),
      title: Text(donor.name),
      subtitle: Text(donor.addharNo),
      trailing: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  ViewDetails(currentDonor: donor,)));
        },
        child: Container(
          alignment: Alignment.center,
          width: 60,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "View",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

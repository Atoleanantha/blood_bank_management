import 'package:blood_bank_management/services/database/DBServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/RegistrationModel.dart';
import 'ViewDetails.dart';

class ViewAllDonors extends StatefulWidget {
  const ViewAllDonors({super.key});

  @override
  State<ViewAllDonors> createState() => _ViewAllDonorsState();
}

class _ViewAllDonorsState extends State<ViewAllDonors> {
  List<RetriveDonorModel>donorsList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("All Donors"),
      ),
      body: FutureBuilder(
          future: DBServices().getAllDonors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: SizedBox(width: 20,height: 20,child: CircularProgressIndicator(),),);
            } else {
              if (snapshot.hasError) {
               return const Center(child: Text("Something went wrong!"),);
              } else {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                    itemBuilder: (context,index){
                      
                  return donorTile(RetriveDonorModel.fromMap(snapshot.data![index]));
                });
              }
            }
            }
      ),
    );
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

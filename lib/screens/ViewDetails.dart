import 'package:blood_bank_management/model/RegistrationModel.dart';
import 'package:blood_bank_management/screens/AddDonorEntry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatelessWidget {
  RetriveDonorModel currentDonor;
  ViewDetails({super.key,required this.currentDonor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Patient Details"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: CircleAvatar(

                  radius: 50,
                  child: Icon(Icons.person,size: 60,),
                ),
              ),
              const SizedBox(height: 10,),
               Text("Full Name : ${currentDonor.name}",style:const TextStyle(fontSize: 18,overflow: TextOverflow.visible),),
              const SizedBox(height: 10,),
              Row(

                children: [
                   Text("Age : ${currentDonor.age}",style: TextStyle(fontSize: 18),),
                  const SizedBox(width: 20,),
                   Text("Gender : ${currentDonor.gender}",style: TextStyle(fontSize: 18),),
                  const SizedBox(width: 20,),
                   Text("Blood Group : ${currentDonor.bloodGroup}",style: TextStyle(fontSize: 18),),
                ],
              ),
              const SizedBox(height: 10,),
               Text("Phone Number : ${currentDonor.phoneNo}",style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
               Text("DOB : ${currentDonor.dob}",style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
               Text("Addhar Number : ${currentDonor.addharNo}",style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
              currentDonor.diseases.isEmpty?
              const Text("Diseases : No diseases",style: TextStyle(fontSize: 18),):
              Text("Diseases : ${currentDonor.diseases}",style: TextStyle(fontSize: 18),),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Address :",style: TextStyle(fontSize: 18,)),
                  Column(
                    children: [
                      Text(currentDonor.address,style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 15),)
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(thickness: 3,),
              const Text("Donation Histry",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              const Divider(thickness: 3,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ListView.builder(
                  itemCount: currentDonor.updateHistory.length,
                    itemBuilder: (context,index){
                  return ListTile(
                    leading: Text((index+1).toString()),
                    title: Text(currentDonor.updateHistory[0]),
                  );
                }),
              ),
              Center(
                child: ElevatedButton(onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDonorEntry(currentDonor: currentDonor,)));

                }, child:const Text("Add Donor entry")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

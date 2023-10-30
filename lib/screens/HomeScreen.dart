
import 'package:blood_bank_management/screens/SearchDonor.dart';
import 'package:blood_bank_management/screens/ViewAllDonors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../services/database/DBServices.dart';
import '../services/internetService.dart';
import 'RegisterNewDonor.dart';

class HomeScreen extends StatefulWidget {

   HomeScreen({super.key,}){

   }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = false;
  Map<String,int> countBloodBags=DBServices.mapBloogBagsCount;
  @override
  void initState() {
    super.initState();
    checkInternetConnectivity().then((result) {
      setState(() {
        isOnline = result;
      });
    });
  }
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    DBServices();
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isRefreshing = false; // Finish refreshing
    });
  }
  Widget showReloadDialog() {
    return AlertDialog(
          title:const Text('No Internet Connection'),
          content:const Text('Please check your internet connection and try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {

              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  DBServices().getConnection();
                });
              },
              child: Text('Reload'),
            ),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    countBloodBags=DBServices.mapBloogBagsCount;
    return Scaffold(
      // backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text("Blood Bank"),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              DBServices();
            });
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.7,
              image:AssetImage("assets/blood.png",),fit: BoxFit.scaleDown,)
        ),
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child:_isRefreshing?Center(
            child: Container(
                height:30,
                width:30,
                color:Colors.grey,
                child: const CircularProgressIndicator()),
          )
              : isOnline? showReloadDialog()
              : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 20),
              child: Column(

                children: [
                  SizedBox(
                    height:height/3 <300?250: height/3 -30,
                    width:width,

                    child: Card(
                        elevation: 10,
                        // color: Colors.red,
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Available Blood Bags",textAlign: TextAlign.center,style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: width>height ?100:(width/4) -20,
                                    height:width>height ?100: (width/4),
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  <Widget>[
                                          const Text("🅰️",style: TextStyle(fontSize: 50,color: Colors.red),),
                                          Text(countBloodBags['A'].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width>height ?100:(width/4) -20,
                                    height:width>height ?100: (width/4),
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  <Widget>[
                                          const Text("🅱️",style: TextStyle(fontSize: 50,color: Colors.red),),
                                          Text(countBloodBags['B'].toString(),style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width>height ?100:(width/4) -20,
                                    height:width>height ?100: (width/4),
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  <Widget>[
                                          const Text("🆎",style: TextStyle(fontSize: 50,color: Colors.red),),
                                          Text(countBloodBags['AB'].toString(),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width>height ?100:(width/4) -20,
                                    height:width>height ?100: (width/4),
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  <Widget>[
                                          const Text("🅾️",style: TextStyle(fontSize: 50,color: Colors.red),),
                                          Text(countBloodBags['O'].toString(),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: width>height ?100:(width/4) -20,
                                    height:width>height ?100: (width/4),
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  <Widget>[
                                          const Text("A-",style: TextStyle(fontSize: 50,color: Colors.red,fontWeight: FontWeight.bold),),
                                          Text(countBloodBags['A-'].toString(),style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width>height ?100:(width/4) -20,
                                    height:width>height ?100: (width/4),
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  <Widget>[
                                          const Text("B-",style: TextStyle(fontSize: 50,color: Colors.red,fontWeight: FontWeight.bold),),
                                          Text(countBloodBags['B-'].toString(),style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width>height ?100:(width/4) -20,
                                    height:width>height ?100: (width/4),
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  <Widget>[
                                          const Text("AB-",style: TextStyle(fontSize: 40,color: Colors.red,fontWeight: FontWeight.bold),),
                                          Text(countBloodBags['AB-'].toString(),style:const  TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width>height ?100:(width/4) -20,
                                    height:width>height ?100: (width/4),
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const Text("O-",style: TextStyle(fontSize: 50,color: Colors.red,fontWeight: FontWeight.bold),),
                                          Text(countBloodBags['O-'].toString(),style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height:height/8 ,
                        width: height/8,
                        child: InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchDonor()));
                            },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.person_search,color: Colors.red,size: 50,),
                                  // Text("🔍",style: TextStyle(fontSize: 50),),
                                  Text("Find Donor",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height:height/8 ,
                        width: height/8,
                        child: InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterNewDonor()));
                            },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.person_add_alt_1,color: Colors.red,size: 50,),
                                  Text("Register New Donor",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height:height/8 ,
                        width: height/8,
                        child: InkWell(onTap:(){},
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.local_hospital,color: Colors.red,size: 50,),
                                  Text("Hospitals",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height:height/8 ,
                        width: height/8,
                        child: InkWell(onTap:(){},
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.request_page_rounded,color: Colors.red,size: 50,),
                                  Text("Requests",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height:height/8 ,
                        width: height/8,
                        child: InkWell(onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewAllDonors()));
                        },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.update,color: Colors.red,size: 50,),
                                  Text("View all Donors",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height:height/8 ,
                        width: height/8,
                        child: InkWell(onTap:(){
                          DBServices().countBloodBags();
                        },
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.info,color: Colors.red,size: 50,),
                                  Text("Other",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

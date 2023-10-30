
import 'package:blood_bank_management/model/RegistrationModel.dart';
import 'package:blood_bank_management/screens/HomeScreen.dart';
import 'package:blood_bank_management/services/database/DBServices.dart';
import 'package:blood_bank_management/services/internetService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterNewDonor extends StatefulWidget {
  const RegisterNewDonor({super.key});

  @override
  State<RegisterNewDonor> createState() => _RegisterNewDonorState();
}

class _RegisterNewDonorState extends State<RegisterNewDonor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String initialChosenBloodGroup = 'A';
  late String selectedGender;
  TextEditingController dateInput = TextEditingController();
  TextEditingController ageInput=TextEditingController();
  TextEditingController addharInput=TextEditingController();
  TextEditingController phoneInput=TextEditingController();
  TextEditingController addressInput=TextEditingController();
  TextEditingController firstNameInput=TextEditingController();
  TextEditingController middleNameInput=TextEditingController();
  TextEditingController surnameInput=TextEditingController();
  bool isNotOnline=false;

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    ageInput.text="";
    selectedGender="";

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    dateInput.dispose();
    phoneInput.dispose();
    firstNameInput.dispose();
    middleNameInput.dispose();
    surnameInput.dispose();
    ageInput.dispose();
    addharInput.dispose();
    addressInput.dispose();
  }

  // List of items in our dropdown menu
  var bloodGroupList = [
    'A',
    'B',
    'AB',
    'O',
    'A-',
    'B-',
    'AB-',
    'O-',
  ];

  Future<void> _submitForm() async {
    if(selectedGender.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select gender",style: TextStyle(color: Colors.red),)));
    }

    if (_formKey.currentState!.validate() && selectedGender.isNotEmpty && !isNotOnline ) {
      String fullName="${surnameInput.text} ${firstNameInput.text} ${middleNameInput.text}";
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: CircularProgressIndicator()));
      bool isInserted=await DBServices().insertNewDonor(
          RegistrationModel(
              name: fullName.toUpperCase(),
              addharNo:addharInput.text.toString(),
              phoneNo: phoneInput.text.toString(),
              bloodGroup: initialChosenBloodGroup,
              gender: selectedGender,
              dob: dateInput.text.toString(),
              age: ageInput.text.toString(),
              address: addressInput.text.toString()));

      if(isInserted) {
        Future.delayed(const Duration(seconds: 2), () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Successful")));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("check addharId donor already registered")));
      }

    }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something went wrong")));

    }
  }

  int calculateAge(selectedDate) {
    final difference = DateTime.now().difference(selectedDate);
    return (difference.inDays / 365.25).floor();
  }

  void chooseDOB() async {
    DateTime? pickedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(),
        firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(DateTime.now().year+1)
    );

    if(pickedDate!=null){
      setState(() {
        dateInput.text = pickedDate.toString().substring(0,10);
        ageInput.text=calculateAge(pickedDate).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity().then((result) {
      isNotOnline = result;
      debugPrint(isNotOnline.toString());
      // setState(() {
      //   debugPrint((!result).toString());
      //
      // });
    });
    return Scaffold(
      appBar: AppBar(
        title:const Text("Register New User"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Padding(
            padding:const EdgeInsets.all(10),
            child: Column(
              children:  [
                TextFormField(
                  controller: firstNameInput,
                  decoration:const InputDecoration(label: Text("First Name")),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter first name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: middleNameInput,
                  decoration:const InputDecoration(label: Text("Middle Name")),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter middle name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: surnameInput,
                  decoration:const InputDecoration(label: Text("Surname Name")),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter surname name";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Addhar Number : ",style: TextStyle(),),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-150,
                      child: TextFormField(
                        controller: addharInput,
                        maxLength: 12,
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value?.length!=12){
                            return "Addhar number should 12 digit";
                          }
                        },
                      ),


                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Phone Number :",style: TextStyle(),),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-150,
                      child: TextFormField(
                        controller: phoneInput,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone)
                        ),
                        validator: (value){
                          if(value?.length!=10){
                            return "Phone number should be 10 digit";
                          }
                        },
                      ),


                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    const Text("Choose blood group : ",style: TextStyle(),),
                    const SizedBox(width: 10,),
                    DropdownButton(

                      hint: const Text("Choose blood group",style: TextStyle(color: Colors.red),),
                      value: initialChosenBloodGroup,
                      icon: const Icon(Icons.keyboard_arrow_down),

                      items: bloodGroupList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          initialChosenBloodGroup = newValue!;
                        });
                      },

                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Gender"),

                    selectGender(),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Date of Birth : ",style: TextStyle(),),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-150,
                      child: TextFormField(
                        controller: dateInput,
                        decoration:const InputDecoration(
                          hintText: "Click here to select DOB",
                            suffixIcon: Icon(Icons.calendar_today), //icon of text field
                        ),
                        readOnly: true,
                        onTap: chooseDOB,
                        validator: (date){
                          if(date!.isEmpty){
                            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Select Date of Birth",style: TextStyle(color: Colors.red),)));
                            return "Please Select Date of Birth";
                          }
                          return null;
                        }
                      ),

                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Age : ",style: TextStyle(),),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-150,
                      child: TextFormField(
                        controller: ageInput,
                        readOnly: true,
                        decoration:const InputDecoration(
                          hintText: "Your Age"
                        ),
                        validator: (value){
                          if(18>(int.tryParse(value!))! ){
                            return "Age should greater than 18";
                          }
                        },
                      ),


                    ),
                  ],
                ),

                const SizedBox(height: 15,),
                Row(
                  children: [
                    const Text("Address : ",style: TextStyle(),),
                    const SizedBox(width: 10,),
                    Container(
                      padding: EdgeInsets.only(left: 10,right: 10,),
                      decoration: BoxDecoration(
                        border: Border.all()
                      ),
                      width: MediaQuery.of(context).size.width-100,
                      child: TextFormField(
                        controller: addressInput,
                        maxLines: 5,
                          validator: (value){
                          if(value!.length==0){
                            return "Enter the address";
                          }
                          }
                      ),

                    ),
                  ],
                ),
                !isNotOnline?
                ElevatedButton(onPressed: _submitForm, child:const Text("Register"))
                    :ElevatedButton(onPressed: (){}, child:const Text("Check internet Connection"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectGender(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Radio(
              // title: const Text('Male'),
              value: 'Male',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            const Text("Male")
          ],
        ),
        Row(
          children: [
            Radio(
              // title: const Text('Male'),
              value: 'Female',
              groupValue: selectedGender,

              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            const Text("Female")
          ],
        ),
        Row(
          children: [
            Radio(
              // title: const Text('Male'),
              value: 'Trans',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            const Text("Trans")
          ],
        ),

      ],
    );
  }
}

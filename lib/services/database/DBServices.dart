
import 'package:blood_bank_management/model/RegistrationModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DBServices {
  static Map<String,int> mapBloogBagsCount={
    'A':0,
    'B':0,
    'AB':0,
    'O':0,
    'A-':0,
    'B-':0,
    'AB-':0,
    'O-':0,
  };
  DBServices(){
    countBloodBags().then((value){
      mapBloogBagsCount=value;
    }) ;
  }
  static String COLLECTION = 'donors';

  Future<Db?> getConnection() async {
    const String USER_NAME = "bloodBank";
    const String PASSWORD = "BloodBank";
    const String dbName = "BloodDonors";

    const String URL = "mongodb+srv://bloodBank:$PASSWORD@bloodbank.mdghlvb.mongodb.net/$dbName?retryWrites=true&w=majority";
    // const String URL='mongodb+srv://$USER_NAME:$PASSWORD@bloodBank.mdghlvb.mongodb.net/$dbName';


    try {
      var db = await Db.create(URL);
      await db.open();
      var collection = db.collection(COLLECTION);
      print(collection.collectionName);
      return db;
    } catch (e) {
      print('Error connecting to MongoDB: $e');
      return null;
    }
  }


  Future<bool> insertNewDonor(RegistrationModel donor) async {
    var _db = await getConnection();
    try {
      final collection = _db!.collection(COLLECTION);
      RetriveDonorModel? model=await getDonorByAddharId(donor.addharNo);
      // Create a new document to insert into the collection.
      final document = {
        'addharId': donor.addharNo, // Assuming 'userId' is the primary key.
        'name': donor.name,
        'mobileNumber': donor.phoneNo,
        'address': donor.address,
        'diseases': donor.diseases,
        'gender': donor.gender,
        'dob': donor.dob,
        'age': donor.age,
        'bloodGroup': donor.bloodGroup,
        'updateHistory': [], // Initialize an empty list for update history.
      };
      print(collection);
      if (collection == "" ) {
        return false;
      }
      // Insert the document into the collection.

        if (model!=null && model.addharNo == donor.addharNo) {
          debugPrint("Donor already preset ${model.addharNo}");
          return false;

      }else {
        await collection.insert(document);
        return true;
      }
    } on Exception catch (e) {
      print('Error inserting data: $e');
      rethrow; // Re-throw the exception for error handling at a higher level.
    }
  }

  Future<RetriveDonorModel?> getDonorByAddharId(String addharId) async {
    Db? _db;
    try {
      _db = await getConnection();
      final collection = _db!.collection(COLLECTION);
      final query = where.eq('addharId', addharId);
      final document = await collection.findOne(query);

      if (document != null) {
        final donor = RetriveDonorModel.fromMap(document);
        print('Retrieved Document: ${donor.name}');
        return donor;
      } else {
        print('Donor not found for addharId: $addharId please register');
        return null;
      }
    } on Exception catch (e) {
      print('Error in searching: $e');
      rethrow; // Re-throw the exception for error handling at a higher level.
    }
  }



  Future<bool> addEntryToDonorHistory(RetriveDonorModel donor, String valueToAdd) async {
    Db? db = await getConnection();
    try {
      final collection = db!.collection(COLLECTION);
      final query = where.eq('addharId', donor.addharNo);
      final update = modify.push('updateHistory', valueToAdd);
      collection.update(query, update);
        await db.close();
        return true;

    }on Exception catch (e) {
      print('Error in inserting: $e');
      return false;
    }

  }

   Future<List<Map<String, dynamic>>> getAllDonors() async {
    Db? db;
    try {
      db=await getConnection();
          final collection=db!.collection(COLLECTION);
          final collectionList=collection.find().toList();
      return collectionList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Map<String, int>> countBloodBags()async{

    Db? db;
    try {
      db=await getConnection();
      final collection=db!.collection(COLLECTION);

      for (var key in mapBloogBagsCount.keys) {
        final countList = await collection.find(where.eq('bloodGroup', key)).toList();
        mapBloogBagsCount[key] = countList.length; // Update the map with the count
      }
      return mapBloogBagsCount;

    } catch (e) {
      print(e);
      return mapBloogBagsCount;
    }
  }
}
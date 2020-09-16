import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drarogyam/models/patients.dart';
import 'package:drarogyam/models/user.dart';

class DatabaseService {
  //collection reference
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference patientCollection =
      Firestore.instance.collection('patient');
  Future updateUserData(String name, String age,
   String score, String flag, String lat, String long) async {
    return await patientCollection.document(uid).setData({
      'name': name,
      'age': age,
      'score':score,
      'flag': flag,
      'lat' : lat,
      'long': long,
    });
  }
  
  Future updatePatientData( String score, String flag, String lat, String long) async {
    return await patientCollection.document(uid).setData({
      'score':score,
      'flag': flag,
      'lat' : lat,
      'long': long,
    });
  }

  List<Patients> _patientListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Patients(
        name: doc.data['name'] ?? '',
        age: doc.data['age'] ?? '',
        score: doc.data['score'] ?? '',
        flag: doc.data['false']??'',
        lat: doc.data['lat']??'',
        long: doc.data['long']??'',
      );
    }).toList();
  }
  //userdatafrm snapshot

  UserData _userDataSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name : snapshot.data['name'],
      age: snapshot.data['age'],
      score: snapshot.data['score'],
      flag: snapshot.data['flag'],
      lat: snapshot.data['lat'],
      long: snapshot.data['long'],
    );
  } 

  Stream<List<Patients>> get patient {
    return patientCollection.snapshots()
      .map(_patientListFromSnapshot);
  }

  //user doc stream
  Stream<UserData> get userData {
    return  patientCollection.document(uid).snapshots()
    .map(_userDataSnapshot);
  }
}


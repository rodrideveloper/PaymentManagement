import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paymen/models/people.dart';

class PeopleService {
  CollectionReference _peopleCollection() {
    final rootRef = FirebaseFirestore.instance;

    return rootRef.collection('Peoples').withConverter<People>(
        fromFirestore: (snapshot, _) => People.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(model));
  }

  Stream<List<People>> getPeople() => _peopleCollection().snapshots().map(
        (snap) => snap.docs
            .map(
              (doc) => doc.data(),
            )
            .whereType<People>()
            .toList(),
      );
}

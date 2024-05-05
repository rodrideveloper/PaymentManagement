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

  Future<void> savePeople(String documento, String nombreApellido, int edad, bool debtor) async {
    try {
      // Añadir un nuevo documento y obtener el ID generado automáticamente
      DocumentReference docRef = await _peopleCollection().add({
        'documento': documento,
        'name': nombreApellido,
        'edad': edad,
        'debtor': debtor, // Agregar el campo 'debtor' con el valor predeterminado de true
        'id': 'x', // Campo para guardar el ID generado
      });

      // Obtener el ID generado y actualizar el documento con ese ID
      String docId = docRef.id;
      await docRef.update({'id': docId}); // Actualizar el campo 'id' con el ID generado

      print("Datos guardados en Firestore");
    } catch (e) {
      print("Error al guardar datos: $e");
    }
  }
}

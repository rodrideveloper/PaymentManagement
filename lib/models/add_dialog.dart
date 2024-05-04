import 'package:flutter/material.dart';

class MiDialogo {
  static void mostrar(BuildContext context, Function(String, String, int) guardarDatos) {
    String documento = '';
    String nombreApellido = '';
    int edad = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Insertar Datos"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  documento = value;
                },
                decoration: const InputDecoration(labelText: 'Documento'),
              ),
              TextField(
                onChanged: (value) {
                  nombreApellido = value;
                },
                decoration: const InputDecoration(labelText: 'Nombre y Apellido'),
              ),
              TextField(
                onChanged: (value) {
                  edad = int.tryParse(value) ?? 0;
                },
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                guardarDatos(documento, nombreApellido, edad);
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}

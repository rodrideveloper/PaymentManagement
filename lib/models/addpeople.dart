import 'package:flutter/material.dart';

class SlidingPanel {
  static void showPanel(BuildContext context, Function(String, String, int, bool) guardarDatos) {
    String documento = '';
    String nombreApellido = '';
    int edad = 0;
    bool debtor = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          builder: (BuildContext context, ScrollController scrollController) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Agregar Huesped',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            onChanged: (value) {
                              documento = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Documento',
                              prefixIcon: const Icon(Icons.assignment),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            onChanged: (value) {
                              nombreApellido = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Nombre y apellido',
                              prefixIcon: const Icon(Icons.account_box),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            onChanged: (value) {
                              edad = int.tryParse(value) ?? 0;
                            },
                            decoration: InputDecoration(
                              labelText: 'Edad',
                              prefixIcon: const Icon(Icons.numbers_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              const Text('Pago?'),
                              const Spacer(),
                              DropdownButton<String>(
                                value: debtor ? 'Sí' : 'No',
                                onChanged: (String? newValue) {
                                  setState(() {
                                    debtor = newValue == 'Sí';
                                  });
                                },
                                items: <String>['Sí', 'No'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  guardarDatos(documento, nombreApellido, edad, debtor);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Guardar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          initialChildSize: 0.6,
          minChildSize: 0.2,
          maxChildSize: 0.6,
        );
      },
    );
  }
}

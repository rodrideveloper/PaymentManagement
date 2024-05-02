import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymen/bloc/people_bloc.dart';
import 'package:paymen/models/addpeople.dart';
import 'package:paymen/models/people.dart';
import 'package:paymen/services.dart/people_service.dart'; 
class HomePAge extends StatefulWidget {
  const HomePAge({super.key});

  @override
  State<HomePAge> createState() => _HomePAgeState();
}


class _HomePAgeState extends State<HomePAge> {
final PeopleService _peopleService = PeopleService();
void _mostrarDialogo(context) {
  SlidingPanel.showPanel(context, (documento, nombreApellido, edad, debtor) {
    _peopleService.savePeople(documento, nombreApellido, edad, debtor);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () {
               _mostrarDialogo(context); 
            },
          ),
        ],
      ),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, state) {
          final currentStatus = state.status;

          switch (currentStatus) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case Status.completed:
              return ListPeopleWidget(
                peoples: state.people,
              );

            default:
              return const Center(
                child: Text('Inicial, vacío o error'),
              );
          }
        },
      ),
    );
  }
}



class ListPeopleWidget extends StatefulWidget {
  const ListPeopleWidget({super.key, required this.peoples});

  final List<People> peoples;

  @override
  State<ListPeopleWidget> createState() => _ListPeopleWidgetState();
}

class _ListPeopleWidgetState extends State<ListPeopleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.peoples.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    widget.peoples[index].name,
                    textAlign: TextAlign.center,
                  ),
                  trailing: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.peoples[index].debtor
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

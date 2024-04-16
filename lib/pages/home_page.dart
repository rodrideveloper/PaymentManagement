import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymen/bloc/people_bloc.dart';
import 'package:paymen/models/people.dart';

class HomePAge extends StatefulWidget {
  const HomePAge({super.key});

  @override
  State<HomePAge> createState() => _HomePAgeState();
}

class _HomePAgeState extends State<HomePAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, state) {
          final currentStatus = state.status;

          switch (currentStatus) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case Status.completed:
              ListPeopleWidget(
                peoples: state.people,
              );
              break;

            default:
              const Center(
                child: Text('Incial, vacio o error'),
              );
          }

          return SizedBox.shrink();
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
    return ListView.builder(
      itemCount: widget.peoples.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.people),
        title: Text(widget.peoples[index].name),
        trailing: Row(
          children: [
            const Text('Debe?'),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.peoples[index].debtor ? Colors.green : Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}

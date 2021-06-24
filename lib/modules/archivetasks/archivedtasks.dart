import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapptestandroidestudio/shared/componant.dart';
import 'package:flutterapptestandroidestudio/shared/cubit/cubit.dart';
import 'package:flutterapptestandroidestudio/shared/cubit/states.dart';

class Archivetasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;

        return taskConditionalBuild(
          tasks: tasks,
        );
      },
    );
  }
}

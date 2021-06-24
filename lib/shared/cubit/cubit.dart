import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapptestandroidestudio/modules/archivetasks/archivedtasks.dart';
import 'package:flutterapptestandroidestudio/modules/donetasks/donetasks.dart';
import 'package:flutterapptestandroidestudio/modules/newtasks/newtasks.dart';
import 'package:flutterapptestandroidestudio/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentindx = 0;
  List screens = [
    Newtasks(),
    Donetasks(),
    Archivetasks(),
  ];
  List titles = [
    'New Tasks',
    'Done Tasks',
    'Archives Tasks',
  ];

  void changeIndex(int index) {
    currentindx = index;
    emit(AppChangeNavBarBottom());
  }

  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;

  void createDataBase1() {
    openDatabase(
      'todo1.db',
      version: 1,
      onCreate: (database, version) {
        print('Create data base');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY , tilte TEXT,date TEXT,time TEXT,stauts TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('there is error her ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print('Open Data Base');
      },
    ).then(
      (value) {
        database = value;
        emit(AppCreateDataBaseState());
      },
    );
  }

  insertIntoDatabase(
      {@required String title, @required String date, @required String time}) {
    database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(tilte, date, time, stauts) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value Inserted Successfully');
        emit(AppInsertDataBaseState());
        getDataFromDataBase(database);
      }).catchError((error) {
        print('there is error her ${error.toString()}');
      });
      return null;
    });
  }

  void updateDataBase({@required String stauts, @required int id}) async {
    database.rawUpdate(
      'UPDATE tasks SET stauts = ? WHERE id = ?',
      ['$stauts', id],
    ).then(
      (value) {
        getDataFromDataBase(database);
        emit(AppUpdateDataBaseState());
      },
    );
  }

  void deleteDataBase({@required int id}) async {
    database
      ..rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then(
        (value) {
          getDataFromDataBase(database);
          emit(AppDeleteDataBaseState());
        },
      );
  }

  void getDataFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['stauts'] == 'new')
          newTasks.add(element);
        else if (element['stauts'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDataBaseState());
    });
  }

  void changeBottomSheet({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShow = isShow;
    fabIcon = icon;
    emit(AppChangBottomSheetState());
  }
}

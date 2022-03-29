import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hello_flutter/model/user.dart';
import 'package:hello_flutter/view_model/user/user_event.dart';

class UserBloc extends Bloc<UserEvent, User> {
  UserBloc(User initialState) : super(initialState) {
    on<UserGenerateRandom>((event, emit) async {
      try {
        User user = await User.getFromAPI(id: event.id);
        emit(user);
      } catch (e) {
        log(e.toString());
        emit(UninitializedUser());
      }
    });
  }
}
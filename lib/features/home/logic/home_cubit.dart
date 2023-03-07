import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(0));

  Future<void> bottomNavItemSelected(int index) async {
    emit(HomeState(index));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class ColorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ColorAmber extends ColorEvent {}
class ColorLightBlue extends ColorEvent {}

class ColorBloc extends Bloc<ColorEvent, Color> {
  ColorBloc(Color initialState) : super(initialState) {
    on<ColorAmber>((event, emit) => emit(Colors.amber));
    on<ColorLightBlue>((event, emit) => emit(Colors.lightBlue));
  }
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Counter on CounterBase, Store {
  final _$nominalAtom = Atom(name: 'CounterBase.nominal');

  @override
  int get nominal {
    _$nominalAtom.reportRead();
    return super.nominal;
  }

  @override
  set nominal(int value) {
    _$nominalAtom.reportWrite(value, super.nominal, () {
      super.nominal = value;
    });
  }

  final _$CounterBaseActionController = ActionController(name: 'CounterBase');

  @override
  void increament() {
    final _$actionInfo = _$CounterBaseActionController.startAction(
        name: 'CounterBase.increament');
    try {
      return super.increament();
    } finally {
      _$CounterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decreament() {
    final _$actionInfo = _$CounterBaseActionController.startAction(
        name: 'CounterBase.decreament');
    try {
      return super.decreament();
    } finally {
      _$CounterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nominal: ${nominal}
    ''';
  }
}

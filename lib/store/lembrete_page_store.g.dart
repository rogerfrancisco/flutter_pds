// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lembrete_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LembretePageStore on LembretePageStoreBase, Store {
  late final _$isSwitchedAtom =
      Atom(name: 'LembretePageStoreBase.isSwitched', context: context);

  @override
  bool get isSwitched {
    _$isSwitchedAtom.reportRead();
    return super.isSwitched;
  }

  @override
  set isSwitched(bool value) {
    _$isSwitchedAtom.reportWrite(value, super.isSwitched, () {
      super.isSwitched = value;
    });
  }

  late final _$LembretePageStoreBaseActionController =
      ActionController(name: 'LembretePageStoreBase', context: context);

  @override
  void setSwitched(bool isSwitched) {
    final _$actionInfo = _$LembretePageStoreBaseActionController.startAction(
        name: 'LembretePageStoreBase.setSwitched');
    try {
      return super.setSwitched(isSwitched);
    } finally {
      _$LembretePageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSwitched: ${isSwitched}
    ''';
  }
}

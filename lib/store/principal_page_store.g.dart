// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'principal_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PrincipalPageStore on PrincipalPageStoreBase, Store {
  late final _$kmAtom =
      Atom(name: 'PrincipalPageStoreBase.km', context: context);

  @override
  int get km {
    _$kmAtom.reportRead();
    return super.km;
  }

  @override
  set km(int value) {
    _$kmAtom.reportWrite(value, super.km, () {
      super.km = value;
    });
  }

  late final _$PrincipalPageStoreBaseActionController =
      ActionController(name: 'PrincipalPageStoreBase', context: context);

  @override
  void setKm(int km) {
    final _$actionInfo = _$PrincipalPageStoreBaseActionController.startAction(
        name: 'PrincipalPageStoreBase.setKm');
    try {
      return super.setKm(km);
    } finally {
      _$PrincipalPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
km: ${km}
    ''';
  }
}

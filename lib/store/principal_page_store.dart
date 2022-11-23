import 'package:mobx/mobx.dart';
part 'principal_page_store.g.dart';

class PrincipalPageStore = PrincipalPageStoreBase with _$PrincipalPageStore;

abstract class PrincipalPageStoreBase with Store {
  @observable
  int km = 0;

  @action
  void setKm(int km) => this.km = km;
}

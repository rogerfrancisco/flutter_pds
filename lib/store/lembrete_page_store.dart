import 'package:mobx/mobx.dart';
part 'lembrete_page_store.g.dart';

class LembretePageStore = LembretePageStoreBase with _$LembretePageStore;

abstract class LembretePageStoreBase with Store {
  @observable
  bool isSwitched = false;
  @action
  void setSwitched(bool isSwitched) => this.isSwitched = isSwitched;
}

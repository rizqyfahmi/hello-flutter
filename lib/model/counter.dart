class Counter {
  int _amount = 0;

  Counter() {
    _amount = 0;
  }

  int get amount => _amount;
  set amount(int value) {
    _amount = value;
  }
}
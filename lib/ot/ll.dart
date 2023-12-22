void main() {
  int a = 1;
  double b = 0.3;
  print("$a, $b");

  List<int> list = [1, 2, 3];
  list.add(1);

  String? ss;
  var length = ss?.length;
  ss ??= "aaa";
  var car = ShoppingCar();
  car.prices = [1.0, 2.0, 3.0];
  car.allPrices;

  var data = MyDataObject();
  data.copyWith(true, newDouble: 1.0, newString: '');
  data.funAc(1, "");

  Map<String, int> map = {"": 1};
  for (var o in map.keys) {}
  map.forEach((key, value) {});
  for (var value in map.values) {}
  map.remove("key");

  List<int> list1 = [1];
  var newList = list + list1;

  Set<int> set = {1, 2};
  String? var1 = null;
  var1 ?? "as";

  cale((int a, int b) {});
  calculator("")?.call(1, 2);

  var acc = Account.simple("yanz", "24");
}

Function? calculator(String operator) {
  if (operator == '+') {
    return (int a, int b) => a + b;
  } else if (operator == '-') {
    return (int a, int b) => a - b;
  } else {
    return null;
  }
}

void cale(Function function) {
  function(1, 2);
}

class ShoppingCar {
  List<double> _prices = [];

  set prices(List<double> prices) {
    _prices = prices;
  }

  get allPrices => _prices;
}

class MyDataObject {
  final int anInt;
  final String aString;
  final double aDouble;

  MyDataObject({
    this.anInt = 1,
    this.aString = 'Old!',
    this.aDouble = 2.0,
  });

  MyDataObject copyWith(bool run,
      {int? newInt = 1, required String? newString, double? newDouble}) {
    return MyDataObject(
        anInt: newInt ?? anInt,
        aString: newString ?? aString,
        aDouble: newDouble ?? aDouble);
  }

  void funAc(int? a, [String? data = "", String? string]) {}
}

class Account {
  String name;
  int age;

  Account(this.name, this.age);

  Account.simple(name, age) : this(name, age);
}

import 'dart:io';

main() {
  for (var animal in Animal.values) {
    print(animal.cn);
  }

  var myColor = MyColor(r: 255, g: 255, b: 255);
  print(myColor.b);

  myColor.haha();

  var record = ('first', a: 2, b: true, 'last');



}
extension MyColorExt on MyColor{
  void haha(){
    print("拓展函数");
  }
}

class MyColor {
  int r = 0;
  int g = 0;
  int? b = 0;

  // MyColor(this.r, this.g, this.b);

  // MyColor([this.r = 0, this.g = 0, this.b]);

  // 可空类型可以不加 required
  MyColor({required this.r, required this.g, this.b});

  MyColor.red() : this(r: 255, g: 0, b: 0);

  MyColor.black()
      : r = 0,
        g = 0,
        b = 0;

  factory MyColor.fromString(String name) {
    if (name == "红色") {
      return MyColor.red();
    } else if (name == "黄色") {
      return MyColor(r: 199, g: 199, b: 89);
    }
    return MyColor.black();
  }
}

// 定义一个枚举类 动物
enum Animal {
  cat(cn: "猫"),
  dog(cn: "狗"),
  fish(cn: "鱼");

  final String cn;

  const Animal({required this.cn});
}

// extension AnimalType on Animal {}

Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    } finally {

    }
  }
}

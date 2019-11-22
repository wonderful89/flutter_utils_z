# flutter_utils_z

## 引入依赖
```
dependencies:
  flutter:
    sdk: flutter

  common_tools:
    git:
       url: "https://github.com/wonderful89/flutter_utils_z.git"
```

## 使用 `CommonTools.getAssetPathPrefix`

```
import 'package:flutter_utils_z/flutter_utils_z.dart';

void initSync() async {
    var dirStr = await CommonTools.getAssetPathPrefix('xxx.png');
    print('dirStr = $dirStr');

    var readDirPath = '$dirStr' + 'assets/images/';
    Directory directory = Directory(readDirPath);
    var pathList = directory.listSync(recursive: false);
    print('pathList = $pathList');
    setState(() {
      paths = pathList.map((item) => item.path).toList();
    });
  }
```

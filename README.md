##### 如何使用

- 1.把这个脚本文件`拷贝`到你项目文件夹，
- 2.在命令行中，进入 `script/i18n_builder` 文件，运行 `dart run.dart .` 即可生成默认的文件。

```shell
cd script/i18n_builder # 进入脚本文件夹
dart run.dart . # 在 lib 下创建名为 I18n 的相关文件
```

![](https://gitee.com/toly1994/res/raw/master/image-20220427073645814.png)

---

如果不想通过命令行，在 `run.dart` 中直接点运行也是可以的。

![](https://gitee.com/toly1994/res/raw/master/image-20220427073950526.png)

---

##### 2. 定制化参数

有两个可定制的参数，分别是生成文件的文件夹，以及调用名。通过命令行可指定参数：

```shell
cd script/i18n_builder # 进入脚本文件夹
dart run.dart -D=lib,src,app -N=S # 在 lib/src/app 下创建名为 S 的相关文件
```

比如上面的命令可以指定在 `lib/src/app` 生成文件，并且调用的类为 `S`。也就是说，在代码中通过下面语句进行访问属性: 默认的调用类是 `I18n` ，你可以自由指定：

```dart
S.of(context).XXX
```

![](https://gitee.com/toly1994/res/raw/master/image-20220427074229758.png)

---

如果直接运行，可以在此进行指定：

![](https://gitee.com/toly1994/res/raw/master/image-20220427074506867.png)

---

##### 3.资源说明

字符资源通过 `json` 的形式给出，如果你想添加一个新语言，只需要提供 `languageCode_countryCode.json` 的文件即可。

![](https://gitee.com/toly1994/res/raw/master/image-20220427074754434.png)

其中支持 `参数变量` ，使用 `{变量名}` 进行设定。另外还支持变量的`默认参数`，通过 `{变量名=默认参数}` 进行指定：

![](https://gitee.com/toly1994/res/raw/master/image-20220427074934705.png)

```dart
---->[使用方式]----
I18n.of(context).info2(count: '$_counter')
I18n.of(context).info2(count: '$_counter',user: 'toly')
```

-----

#### 支持多语言的流程

##### 1. 准备工作

实现在 `pubspec.yaml` 文件中添加 `flutter_localizations` 的依赖：

```yaml
dependencies:
  #...
  flutter_localizations: 
    sdk: flutter
```

---

在使用时我们需要在 `MaterialApp` 中配置三个参数：

- `tag1` : 代理类列表。其中 `I18nDelegate` 是通过脚本生成的代理类
- `tag2`: 语言支持的列表。
- `tag3` : 当前支持的语言。

```dart
MaterialApp(
		//...
    localizationsDelegates: [ // tag1
      ...GlobalMaterialLocalizations.delegates,
      I18nDelegate.delegate 
    ],
    supportedLocales: I18nDelegate.delegate.supportedLocales, // tag2
    locale: const Locale('zh', 'CH'), // tag3
);
```

多语言切换的功能实现其实非常简单，修改 `tag3` 处的 `locale` 参数即可。



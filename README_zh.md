# auth_flow_riverpod2
受如下项目启发，流程讲述很清除，但是手工实现代码有点费劲，而里面的参考项目是一个完整项目，不适合作为学习的起点，想着看看是否能用ai生成一些代码，于是就有了这个项目。
这个项目基本都是通过deepseek ai自动生成的，我只是稍微修改了一下。
主要参考项目：
- [How to Build a Robust Flutter App Initialization Flow with Riverpod](https://codewithandrea.com/articles/robust-app-initialization-riverpod/)

## 主要提示词
使用goRouter和Rivepod2 的自动生成机制构造一个有flash page,等待一些初始操作完成后，这些初始操作包括的sharepreference,本地数据库的初始化等，然后检查是否有用户登录过，如果登录过，自动登录，然后进入主页面，否则进入登录页面。根据前面需求生成一个初始flutter项目，生成的代码用不同的文件组织，便于理解和维护。需要时完整的代码，可以运行。

```shell
flutter pub get
flutter pub run build_runner
flutter run
```
# iOS-WebView

事前課題をiOSで実装したものです。

AlertやPromptを踏むとアプリ側で用意した処理(=アプリ内Alert)が出ます。それだけだと普通のAlertっぽいので、ついでに背景の色を変えるなどしました。

![normal](https://github.com/hideo54/seccamp2016-6A/raw/master/normal.png)
![alert](https://github.com/hideo54/seccamp2016-6A/raw/master/alert.png)
![prompt](https://github.com/hideo54/seccamp2016-6A/raw/master/prompt.png)

## 構成

### iOSアプリ用ファイル群

* iOS-WebView.xcodeprj
* iOS-WebView/

### Alert/Prompt発火用テストサーバー

* TestAlertServer/

起動:
```
cd TestAlertServer/
node main.js
```

#  RadarKit
快速接入 Radar

## 使用
在项目中使用`RKFeedbackLink`或`RKFeedbackView`即可直接接入。

### `RKFeedbackLink`
指向反馈页面的 NavigationLink
#### 参数
`checkUpdate`: 检查更新设置

`projectName`: 项目名

`gatherAppdiagnose`: 收集 App 诊断信息

`showUnderstandStatus`: 显示“了解反馈状态”

---

### `RKFeedbackView`
反馈助理主页
#### 参数
`projName`: 项目名

`gatherAppdiagnose`: 收集 App 诊断信息

`showUnderstandStatus`: 显示“了解反馈状态”

## 高级
使用`radar`开头的视图 modifiers 来自定义反馈页面和提交信息等内容。

### `radarFAQView(_:)`
在“反馈助理”页面中显示常见问题
#### 参数
`_`: 常见问题导航到的页面

---

### `radarTitleInputSample(_:)`
新建反馈时标题输入下方的提示信息
#### 参数
`_`: 提示信息文本

---

### `radarAttachmentSelector(_:)`    
提交反馈前可供用户选择附件的页面
#### 讨论
传入一个接受 completionHandler 的视图，在用户完成选择后向 RadarKit 回调对应的 Key 和 Value

```swift
RKFeedbackView(...)
    .radarAttachmentSelector { completion in
       Button("Select") {
           completion("Key", "Value")
       }
    }
```

Value 会同时显示在“附件”列表中。
#### 参数
`_`: 附件选择页，RadarKit 将其使用 sheet 推出。

---

### `radarAdditionalData(_:)`
添加到反馈的附加数据。
#### 参数
`_`: 包含附加数据的字典。

---

### `radarTipper(_:)`
用于 RadarKit 在需要时向用户显示提示的方法。
#### 讨论
传入的方法第一个参数为提示内容，第二个参数为建议的 SF 符号。

```swift
RKFeedbackView()
    .radarTipper { content, symbol in
        showTip(text: content, symbol: symbol)
    }
```
#### 参数
`_`: 需要显示提示时调用的方法。

---

### `radarOnNewFeedbackAppear(_:)`
在进入“新建反馈”页后调用自定义方法。
#### 参数
`_`: 进入“新建反馈”页后调用的方法。

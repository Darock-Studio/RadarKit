//
//  Environment.swift
//  RadarKit
//
//  Created by memz233 on 7/30/24.
//

import SwiftUI

struct FAQViewKey: EnvironmentKey, Equatable {
    static var defaultValue: AnyView? = nil
}
extension EnvironmentValues {
    var FAQView: AnyView? {
        get { self[FAQViewKey.self] }
        set { self[FAQViewKey.self] = newValue }
    }
}

struct FeedbackTitleSampleKey: EnvironmentKey, Equatable {
    static var defaultValue: LocalizedStringKey = ""
}
extension EnvironmentValues {
    var FeedbackTitleSample: LocalizedStringKey {
        get { self[FeedbackTitleSampleKey.self] }
        set { self[FeedbackTitleSampleKey.self] = newValue }
    }
}

struct FeedbackAttachmentSelectorKey: EnvironmentKey, Equatable {
    static var defaultValue: ((@escaping (String, String) -> Void) -> AnyView)?
}
extension EnvironmentValues {
    var FeedbackAttachmentSelector: ((@escaping (String, String) -> Void) -> AnyView)? {
        get { self[FeedbackAttachmentSelectorKey.self] }
        set { self[FeedbackAttachmentSelectorKey.self] = newValue }
    }
}

struct FeedbackExtDataKey: EnvironmentKey, Equatable {
    static var defaultValue: [String: String] = [:]
}
extension EnvironmentValues {
    var FeedbackExtData: [String: String] {
        get { self[FeedbackExtDataKey.self] }
        set { self[FeedbackExtDataKey.self] = newValue }
    }
}

struct TipperKey: EnvironmentKey, Equatable {
    static var defaultValue: ((LocalizedStringKey, String) -> Void)?
}
extension EnvironmentValues {
    var Tipper: ((LocalizedStringKey, String) -> Void)? {
        get { self[TipperKey.self] }
        set { self[TipperKey.self] = newValue }
    }
}

struct NewFeedbackActionKey: EnvironmentKey, Equatable {
    static var defaultValue: (() -> Void)?
}
extension EnvironmentValues {
    var NewFeedbackAction: (() -> Void)? {
        get { self[NewFeedbackActionKey.self] }
        set { self[NewFeedbackActionKey.self] = newValue }
    }
}

public extension View {
    /// 在“反馈助理”页面中显示常见问题
    /// - Parameter view: 常见问题导航到的页面
    func radarFAQView<T>(_ view: T) -> some View where T: View {
        self.environment(\.FAQView, AnyView(view))
    }
    
    /// 新建反馈时标题输入下方的提示信息
    /// - Parameter key: 提示信息文本
    func radarTitleInputSample(_ key: LocalizedStringKey) -> some View {
        self.environment(\.FeedbackTitleSample, key)
    }
    /// 新建反馈时标题输入下方的提示信息
    /// - Parameter key: 提示信息文本
    @_disfavoredOverload
    func radarTitleInputSample(_ key: String) -> some View {
        self.environment(\.FeedbackTitleSample, "\(key)")
    }
    
    /// 提交反馈前可供用户选择附件的页面
    ///
    /// 传入一个接受 completionHandler 的视图，在用户完成选择后向 RadarKit 回调对应的 Key 和 Value
    ///
    /// ```swift
    /// RKFeedbackView(...)
    ///     .radarAttachmentSelector { completion in
    ///        Button("Select") {
    ///            completion("Key", "Value")
    ///        }
    ///     }
    /// ```
    ///
    /// Value 会同时显示在“附件”列表中。
    ///
    /// - Parameter view: 附件选择页，RadarKit 将其使用 sheet 推出。
    func radarAttachmentSelector<T>(@ViewBuilder _ view: @escaping (@escaping (String, String) -> Void) -> T) -> some View where T: View {
        self.environment(\.FeedbackAttachmentSelector) { closure in
            AnyView(view(closure))
        }
    }
    
    /// 添加到反馈的附加数据。
    /// - Parameter data: 包含附加数据的字典。
    func radarAdditionalData(_ data: [String: String]) -> some View {
        self.environment(\.FeedbackExtData, data)
    }
    
    /// 用于 RadarKit 在需要时向用户显示提示的方法。
    ///
    /// 传入的方法第一个参数为提示内容，第二个参数为建议的 SF 符号。
    ///
    /// ```swift
    /// RKFeedbackView()
    ///     .radarTipper { content, symbol in
    ///         showTip(text: content, symbol: symbol)
    ///     }
    /// ```
    ///
    /// - Parameter tipper: 需要显示提示时调用的方法。
    func radarTipper(_ tipper: @escaping (LocalizedStringKey, String) -> Void) -> some View {
        self.environment(\.Tipper, tipper)
    }
    
    /// 在进入“新建反馈”页后调用自定义方法。
    /// - Parameter action: 进入“新建反馈”页后调用的方法。
    func radarOnNewFeedbackAppear(_ action: @escaping () -> Void) -> some View {
        self.environment(\.NewFeedbackAction, action)
    }
}

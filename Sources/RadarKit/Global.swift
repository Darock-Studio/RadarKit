//
//  Global.swift
//  RadarKit
//
//  Created by memz233 on 7/30/24.
//

import SwiftUI

let globalStates: [LocalizedStringKey] = [
    "未标记",
    "按预期工作",
    "无法修复",
    "问题重复",
    "搁置",
    "正在修复",
    "已在未来版本修复",
    "已修复",
    "正在加载",
    "未能复现",
    "问题并不与App相关",
    "需要更多细节",
    "被删除"
]
let globalStateColors = [
    Color.secondary,
    Color.red,
    Color.red,
    Color.red,
    Color.orange,
    Color.orange,
    Color.orange,
    Color.green,
    Color.secondary,
    Color.red,
    Color.secondary,
    Color.orange,
    Color.red
]
let globalStateIcons = [
    "minus",
    "curlybraces",
    "xmark",
    "arrow.triangle.pull",
    "books.vertical",
    "hammer",
    "clock.badge.checkmark",
    "checkmark",
    "ellipsis",
    "questionmark",
    "bolt.horizontal",
    "arrowshape.turn.up.backward.badge.clock",
    "xmark.square.fill"
]

#if os(watchOS)
let systemVersion = WKInterfaceDevice.current().systemVersion
#else
let systemVersion = UIDevice.current.systemVersion
#endif

func getSettingsForAppdiagnose(dataProcessor: (inout [String: Any]) -> Void = { _ in }) -> String? {
    let prefPath = NSHomeDirectory() + "/Library/Preferences/\(Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String).plist"
    if let plistData = FileManager.default.contents(atPath: prefPath) {
        do {
            if var plistObject = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any] {
                dataProcessor(&plistObject)
                let jsonData = try JSONSerialization.data(withJSONObject: plistObject)
                return String(decoding: jsonData, as: UTF8.self)
            }
        } catch {
            print(error)
        }
    }
    return nil
}

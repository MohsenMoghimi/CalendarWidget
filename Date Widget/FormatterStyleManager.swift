//
//  FormatterStyleManager.swift
//  Date Widget
//
//  Created by Mohsen Moghimi on 1/5/20.
//  Copyright © 2020 Mohsen Moghimi. All rights reserved.
//

import Foundation

class FormatterStyleManager {
    static let shared = FormatterStyleManager()
    
    private init() {}
    
    private var shamsiStyle: DateFormatter.Style!
    private var kharejiStyle: DateFormatter.Style!
    private var ghamariStyle: DateFormatter.Style!
    
    func setShamsiStyleTo(style: DateFormatter.Style) {
        let s = convertStyleToString(style: style)
        UserDefaults.standard.set(s, forKey: "shamsiStyle")
    }
    
    func setKharejiStyleTo(style: DateFormatter.Style) {
        let s = convertStyleToString(style: style)
        UserDefaults.standard.set(s, forKey: "kharejiStyle")
    }
    
    func setGhamariStyleTo(style: DateFormatter.Style) {
        let s = convertStyleToString(style: style)
        UserDefaults.standard.set(s, forKey: "ghamariStyle")
    }
    
    
    func getShamsiStyle() -> DateFormatter.Style {
        guard let style = UserDefaults.standard.value(forKey: "shamsiStyle") else {
            let style : DateFormatter.Style = .medium
            let s = convertStyleToString(style: style)
            UserDefaults.standard.set(s, forKey: "shamsiStyle")
            return style
        }
        return convertStyleToFormatterStyle(style: style as! String)
    }
    
    func getKharejiStyle() -> DateFormatter.Style {
        guard let style = UserDefaults.standard.value(forKey: "kharejiStyle") else {
            let style : DateFormatter.Style = .medium
            let s = convertStyleToString(style: style)
            UserDefaults.standard.set(s, forKey: "kharejiStyle")
            return style
        }
        return convertStyleToFormatterStyle(style: style as! String)
    }
    
    func getGhamariStyle() -> DateFormatter.Style {
        guard let style = UserDefaults.standard.value(forKey: "ghamariStyle") else {
            let style : DateFormatter.Style = .medium
            let s = convertStyleToString(style: style)
            UserDefaults.standard.set(s, forKey: "ghamariStyle")
            return style
        }
        
        return convertStyleToFormatterStyle(style: style as! String)
    }
    
    func convertStyleToString(style: DateFormatter.Style) -> String {
        switch style {
        case .full:
            return "full"
        case .long:
            return "long"
        case .medium:
            return "medium"
        default:
            return "short"
        }
    }
    
    func convertStyleToFormatterStyle(style: String) -> DateFormatter.Style {
        if style == "full"{
            return .full
        } else if style == "long" {
            return .long
        } else if style == "medium" {
            return .medium
        } else {
            return .short
        }
    }
}

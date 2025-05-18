//
//  Bundle+Ext.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 01/05/25.
//

import Foundation

extension Bundle {
    func getValue(for key: String, from plist: String = "Keys") -> String? {
        guard let path = self.path(forResource: plist, ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            return nil
        }
        return dict[key] as? String
    }
} 
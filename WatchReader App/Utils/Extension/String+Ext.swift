//
//  String+Ext.swift
//  WatchReader App
//
//  Created by Hanh Vu on 2023/08/02.
//

import Foundation

extension String {
    func replaceSpaceWithPlus() -> String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
}

//
//  Array+Listed.swift
//  ObjCFileFinder
//
//  Created by Rachel Schneebaum on 3/20/19.
//  Copyright © 2019 ovuline. All rights reserved.
//

import Foundation

extension Array where Element == String {
    /// A string representation of all elements, each on a new line.
    var listed: String {
        return map { $0 }.joined(separator: "\n")
    }
}

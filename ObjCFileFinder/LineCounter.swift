//
//  LineCounter.swift
//  ObjCFileFinder
//
//  Created by Rachel Schneebaum on 3/20/19.
//  Copyright © 2019 ovuline. All rights reserved.
//

import Foundation

struct LineCounter {

    enum Prefix: CaseIterable {
        case comment
        case end
        case importStatement
        case pragmaMark

        var substring: String {
            switch self {
            case .comment:          return "//"
            case .end:              return "@end"
            case .importStatement:  return "#import"
            case .pragmaMark:       return "#pragma"
            }
        }

        var count: Int {
            return substring.count
        }

        func lineContains(_ line: String) -> Bool {
            return String(line.prefix(self.count)) == self.substring
        }
    }

    /// Returns all lines of a readable file, excluding non-code lines (comments, import statements,
    /// whitespace, etc.).
    static func lines(inFileString fileString: String) -> [String] {
        let lines = fileString.components(separatedBy: .newlines)

        return lines
            // Remove comments, import statements, pragma marks
            .filter({ line in
                var containsIllegalPrefix = false

                Prefix.allCases.forEach {
                    if $0.lineContains(line) {
                        containsIllegalPrefix = true
                    }
                }

                return !containsIllegalPrefix
            })
            // Remove blank lines
            .filter { $0 != "" }
    }
}

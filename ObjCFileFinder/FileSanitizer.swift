//
//  FileSanitizer.swift
//  ObjCFileFinder
//
//  Created by Rachel Schneebaum on 3/20/19.
//  Copyright © 2019 ovuline. All rights reserved.
//

import Foundation

struct FileSanitizer {

    static func getFileNamesFromPaths(_ paths: [String]) -> [String] {
        return paths.map {
            let components = $0.components(separatedBy: "/")
            if let lastComponent = components.last {
                return lastComponent
            } else {
                return $0
            }
        }
    }

    static func listFileNames(_ fileNames: [String]) -> String {
        return fileNames.map { $0 }.joined(separator: "\n")
    }
}

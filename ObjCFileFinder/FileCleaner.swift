//
//  FileSanitizer.swift
//  ObjCFileFinder
//
//  Created by Rachel Schneebaum on 3/20/19.
//  Copyright © 2019 ovuline. All rights reserved.
//

import Foundation

struct FileCleaner {

    /// Takes an array of paths and returns just the filenames for each.
    static func getFileNamesAtPaths(_ paths: [String]) -> [String] {
        return paths.map { fileName(at: $0) }
    }

    /// Returns the filename at a given path.
    static func fileName(at path: String) -> String {
        let components = path.components(separatedBy: "/")
        if let lastComponent = components.last {
            return lastComponent
        } else {
            return path
        }
    }
}

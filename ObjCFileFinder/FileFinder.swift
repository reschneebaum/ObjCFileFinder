//
//  FileFinder.swift
//  ObjCFileFinder
//
//  Created by Rachel Schneebaum on 3/19/19.
//  Copyright © 2019 ovuline. All rights reserved.
//

import Foundation

struct FileFinder {
    static let fileManager = FileManager.default

    /// Looks specifically for Objective-C files in our directories —- so, excluding carthage files, cocoapods
    /// files, headers, private headers, and manually added external code.
    static func findOviaObjectiveCFiles(_ path: String) -> [String] {
        return findFilesInDirectory(
            path,
            withSuffixes: [
//                "h",
                "m"
            ],
            excludingSubdirectories: [
                "Headers",
                "PrivateHeaders",
                "Pod",
                "External",
                "Carthage",
                "Frameworks"
            ]
        )
    }


    static func findFilesInDirectory(_ path: String,
                                     withSuffixes suffixes: [String],
                                     excludingSubdirectories directoryPaths: [String]) -> [String] {
        let enumerator = fileManager.enumerator(atPath: path)
        var allFiles: [String] = []

        while let file = enumerator?.nextObject() as? String {
            if !directoryPaths.contains(where: file.contains) {
                if let suffix = file.components(separatedBy: ".").last {
                    if suffixes.contains(suffix) {
                        allFiles.append(file)
                    }
                }
            }
        }

        return allFiles
    }
}

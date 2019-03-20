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

    /// Looks specifically for internal Objective-C files —- so, excluding carthage, cocoapods,
    /// headers, private headers, and (if enclosed in an 'External' folder) manually added external code.
    static func findInternalObjectiveCFiles(_ path: String) -> [String] {
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

    /// Returns all paths in a given directory (and its subdirectories) that include the specified suffixes
    /// (if provided) and exlude any paths in the specified subdirectories (if provided).
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

    /// Converts an array of paths to an array of string representations of the readable files at those paths.
    static func fileStrings(for paths: [String], inDirectory directoryPath: String) -> [String] {
        return paths.compactMap { stringForFile(at: $0, inDirectory: directoryPath) }
    }

    /// Converts a path to a string representation of the file at that path (if readable).
    static func stringForFile(at path: String, inDirectory directoryPath: String) -> String? {
        let fullPath = "\(directoryPath)/\(path)"
        let expandedPath = (fullPath as NSString).expandingTildeInPath
        guard fileManager.fileExists(atPath: expandedPath) else { return nil }
        guard fileManager.isReadableFile(atPath: expandedPath) else { return nil }
        let fileURL = URL(fileURLWithPath: expandedPath)
        return try? String(contentsOf: fileURL)
    }
}

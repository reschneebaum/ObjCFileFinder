//
//  main.swift
//  ObjCFileFinder
//
//  Created by Rachel Schneebaum on 3/19/19.
//  Copyright © 2019 ovuline. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments.map { argument in
    let filePaths = FileFinder.findInternalObjectiveCFiles(argument)

    let countedFiles = filePaths.map { path -> String in
        let fileName = FileCleaner.fileName(at: path)
        var printableString = fileName

        if let fileString = FileFinder.stringForFile(at: path, inDirectory: argument) {
            let numberOfLines = LineCounter.lines(inFileString: fileString).count
            printableString += ", \(numberOfLines) lines"
        }

        return printableString
    }

    print(countedFiles.listed)
    print("There are \(filePaths.count) Objective-C files in this directory.")
}


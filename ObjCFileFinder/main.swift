//
//  main.swift
//  ObjCFileFinder
//
//  Created by Rachel Schneebaum on 3/19/19.
//  Copyright © 2019 ovuline. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments.map {
    let filePaths = FileFinder.findOviaObjectiveCFiles($0)
    let fileNames = FileSanitizer.getFileNamesFromPaths(filePaths)

    print(FileSanitizer.listFileNames(fileNames))
    print("There are \(fileNames.count) Objective-C files in our project.")
}


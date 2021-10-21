#!/usr/bin/env swift

import Foundation

var inputs = CommandLine.arguments

var project = ProcessInfo.processInfo.environment["PROJECT"]
var workspace = ProcessInfo.processInfo.environment["WORKSPACE"]
var scheme = ProcessInfo.processInfo.environment["SCHEME"]
var destination = ProcessInfo.processInfo.environment["DESTINATION"]
var githubRunId = ProcessInfo.processInfo.environment["GITHUB_RUN_ID"]

var workspaceArguments: [String] = [
    "-workspace",
    "\(workspace!)",
]

var projectArguments: [String] = [
    "-project",
    "\(project!)",
]

var arguments: [String] = [
    "xcodebuild",
    "clean",
    "test"
]

var standartArguments: [String] = [
    "-scheme",
    "\(scheme!)",
    "-destination",
    "\(destination!)",
    "-resultBundlePath",
    "\"Build/Result/\(githubRunId!)-iOS15-Simulator.xcresult\"",
    "-derivedDataPath",
    "Build/DerivedData | xcpretty && exit"
]

var packResultBundle: [String] = [
    "arch",
    "-arm64",
    "zip",
    "-X",
    "-resultBundlePath",
    "Build/\(githubRunId!)-Xcresult.zip",
    "-derivedDataPath",
    "Build/Result"
]

if project == "" {
    arguments.append(contentsOf: workspaceArguments)
    arguments.append(contentsOf: standartArguments)
} else {
    arguments.append(contentsOf: projectArguments)
    arguments.append(contentsOf: standartArguments)
}

@discardableResult
func shell(_ args: [String]) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

var status = shell(arguments)

shell(packResultBundle)

exit(status)



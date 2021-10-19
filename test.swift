#!/usr/bin/swift

import Foundation

var inputs = CommandLine.arguments

var project = ProcessInfo.processInfo.environment["project"]
var workspace = ProcessInfo.processInfo.environment["workspace"]
var scheme = ProcessInfo.processInfo.environment["scheme"]
var destination = ProcessInfo.processInfo.environment["destination"]
var githubRunId = ProcessInfo.processInfo.environment["GITHUB_RUN_ID"]
var pipeStatus = ProcessInfo.processInfo.environment["PIPESTATUS"]

print(githubRunId!)
print(pipeStatus!)

var arguments: [String]

if let project == "" {
    arguments = workspaceArguments
} else {
    arguments = projectArguments
}

var workspaceArguments: [String] = [
    "-workspace \(workspace!)",
    "-scheme \(scheme!)",
    "-destination \(destination!)",
    "-resultBundlePath 'Build/Result/\(githubRunId!)-iOS15-Simulator.xcresult'",
    "-derivedDataPath Build/DerivedData | xcpretty && exit \(pipeStatus!.first!)"
]

var projectArguments: [String] = [
    "-project \(project!)",
    "-scheme \(scheme!)",
    "-destination \(destination!)",
    "-resultBundlePath 'Build/Result/\(githubRunId!)-iOS15-Simulator.xcresult'",
    "-derivedDataPath Build/DerivedData | xcpretty && exit \(pipeStatus!.first!)"
]

if inputs.count > 1 {
    for input in inputs {
        print(input)
    }

    let task = Process()
    task.launchPath = "xcodebuild"
    task.arguments = arguments
    task.launch()
    task.waitUntilExit()
}

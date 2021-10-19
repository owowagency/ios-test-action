#!/usr/bin/swift

import Foundation

var inputs = CommandLine.arguments

var project = ProcessInfo.processInfo.environment["PROJECT"]
var workspace = ProcessInfo.processInfo.environment["WORKSPACE"]
var scheme = ProcessInfo.processInfo.environment["SCHEME"]
var destination = ProcessInfo.processInfo.environment["DESTINATION"]
var githubRunId = ProcessInfo.processInfo.environment["GITHUB_RUN_ID"]
var pipeStatus = ProcessInfo.processInfo.environment["PIPESTATUS[0]"]

print(project!)
print(workspace!)
print(scheme!)
print(destination!)
print(githubRunId!)
print(pipeStatus!)

var arguments: [String]

if project == "" {
    arguments = workspaceArguments
} else {
    arguments = projectArguments
}

var workspaceArguments: [String] = [
    "-workspace \(workspace!)",
    "-scheme \(scheme!)",
    "-destination \(destination!)",
    "-resultBundlePath 'Build/Result/\(githubRunId!)-iOS15-Simulator.xcresult'",
    "-derivedDataPath Build/DerivedData | xcpretty && exit \(pipeStatus!)"
]

var projectArguments: [String] = [
    "-project \(project!)",
    "-scheme \(scheme!)",
    "-destination \(destination!)",
    "-resultBundlePath 'Build/Result/\(githubRunId!)-iOS15-Simulator.xcresult'",
    "-derivedDataPath Build/DerivedData | xcpretty && exit \(pipeStatus!)"
]

let task = Process()
task.launchPath = "xcodebuild"
task.arguments = arguments
task.launch()
task.waitUntilExit()

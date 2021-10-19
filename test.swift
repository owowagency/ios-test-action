#!/usr/bin/swift

import Foundation

var inputs = CommandLine.arguments

var project = ProcessInfo.processInfo.environment["PROJECT"]
var workspace = ProcessInfo.processInfo.environment["WORKSPACE"]
var scheme = ProcessInfo.processInfo.environment["SCHEME"]
var destination = ProcessInfo.processInfo.environment["DESTINATION"]
var githubRunId = ProcessInfo.processInfo.environment["GITHUB_RUN_ID"]
var pipeStatus = ProcessInfo.processInfo.environment["PIPESTATUS"]

//var osVersion  = String(destination).suffix(3)

if let project = project {
    print(project)
}
if let workspace = workspace {
    print(workspace)
}
if let scheme = scheme {
    print(scheme)
}
if let destination = destination {
    print(destination)
}
if let githubRunId = githubRunId {
    print(githubRunId)
}
if let pipeStatus = pipeStatus {
    print(pipeStatus)
}

//print(osVersion)

var arguments: [String] = []

var workspaceArguments: [String] = [
    "arch -arm64 xcodebuild clean test",
    "-workspace \(workspace!)",
    "-scheme \"\(scheme!)\"",
    "-destination \"\(destination!)\"",
    "-resultBundlePath \"Build/Result/\(githubRunId!)-iOS15-Simulator.xcresult\"",
    "-derivedDataPath Build/DerivedData | xcpretty && exit"
]

var projectArguments: [String] = [
    "arch -arm64 xcodebuild clean test",
    "-project \(project!)",
    "-scheme \(scheme!)",
    "-destination \(destination!)",
    "-resultBundlePath \"Build/Result/\(githubRunId!)-iOS15-Simulator.xcresult\"",
    "-derivedDataPath Build/DerivedData | xcpretty && exit"
]

if project == "" {
    arguments = workspaceArguments
} else {
    arguments = projectArguments
}

for argument in arguments {
    print(argument)
}

let task = Process()
task.launchPath = "/usr/bin/env"
task.arguments = arguments
task.launch()
task.waitUntilExit()

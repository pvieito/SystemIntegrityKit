//
//  main.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 2/7/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import LoggerKit
import CommandLineKit
import SystemIntegrityKit

let inputOption = StringOption(shortFlag: "i", longFlag: "input", helpMessage: "Input binary configuration.")
let unrestrictedOption = BoolOption(shortFlag: "u", longFlag: "unrestricted", helpMessage: "Unrestricted configuration.")
let setOption = BoolOption(shortFlag: "s", longFlag: "set", helpMessage: "Set input configuration.")
let verboseOption = BoolOption(shortFlag: "v", longFlag: "verbose", helpMessage: "Verbose mode.")
let debugOption = BoolOption(shortFlag: "d", longFlag: "debug", helpMessage: "Debug mode.")
let helpOption = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Prints a help message.")

let cli = CommandLineKit.CommandLine()
cli.addOptions(inputOption, unrestrictedOption, setOption, verboseOption, debugOption, helpOption)

do {
    try cli.parse(strict: true)
}
catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if helpOption.value {
    cli.printUsage()
    exit(-1)
}

Logger.logMode = .commandLine
Logger.logLevel = verboseOption.value ? .verbose : .info
Logger.logLevel = debugOption.value ? .debug : Logger.logLevel
    

var inputConfiguration: SystemIntegrityConfiguration
var configurationName: String

if let binaryConfiguration = inputOption.value {
    guard let configuration = SystemIntegrityConfiguration(binaryConfiguration: binaryConfiguration) else {
        Logger.log(error: "Invalid input configuration “\(binaryConfiguration)”.")
        exit(-1)
    }
    
    inputConfiguration = configuration
    configurationName = "Input"
}
else if unrestrictedOption.value {
    inputConfiguration = .unrestricted
    configurationName = "Unrestricted"
}
else {
    inputConfiguration = SystemIntegrityManager.currentConfiguration
    configurationName = "Current"
}

inputConfiguration.printDetails(name: configurationName)

if setOption.value {
    Logger.log(debug: "Setting System Integrity Protection configuration to “\(inputConfiguration)”...")
    
    do {
        try SystemIntegrityManager.setConfiguration(to: inputConfiguration)
        Logger.log(success: "System Integrity Protection successfully set to “\(inputConfiguration)”.")
    }
    catch {
        Logger.log(error: error)
    }
}

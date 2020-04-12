//
//  main.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 2/7/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import LoggerKit
import SystemIntegrityKit
import ArgumentParser

struct SystemIntegrityTool: ParsableCommand {
    static var configuration: CommandConfiguration {
        return CommandConfiguration(commandName: String(describing: Self.self))
    }
    
    @Option(name: .shortAndLong, help: "Input binary configuration.")
    var input: String?
    
    @Flag(name: .shortAndLong, help: "Unrestricted configuration.")
    var unrestricted: Bool

    @Flag(name: .shortAndLong, help: "Set input configuration.")
    var set: Bool

    @Flag(name: .shortAndLong, help: "Verbose mode.")
    var verbose: Bool
    
    @Flag(name: .shortAndLong, help: "Debug mode.")
    var debug: Bool
    
    func run() throws {
        do {
            Logger.logMode = .commandLine
            Logger.logLevel = verbose ? .verbose : .info
            Logger.logLevel = debug ? .debug : Logger.logLevel

            var inputConfiguration: SystemIntegrityConfiguration
            var configurationName: String
            
            if let binaryConfiguration = self.input {
                guard let configuration = SystemIntegrityConfiguration(binaryConfiguration: binaryConfiguration) else {
                    Logger.log(fatalError: "Invalid input configuration “\(binaryConfiguration)”.")
                }
                
                inputConfiguration = configuration
                configurationName = "Input"
            }
            else if unrestricted {
                inputConfiguration = .unrestricted
                configurationName = "Unrestricted"
            }
            else {
                inputConfiguration = try SystemIntegrityManager.readCurrentConfiguration()
                configurationName = "Current"
            }
            
            inputConfiguration.printDetails(name: configurationName)
            
            if set {
                Logger.log(debug: "Setting System Integrity Protection configuration to “\(inputConfiguration)”...")
                
                try SystemIntegrityManager.setConfiguration(to: inputConfiguration)
                Logger.log(success: "System Integrity Protection successfully set to “\(inputConfiguration)”.")
            }
        }
        catch {
            Logger.log(fatalError: error)
        }
    }
}

SystemIntegrityTool.main()

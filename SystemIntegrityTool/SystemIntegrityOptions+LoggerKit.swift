//
//  SystemIntegrityOptions+LoggerKit.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 24/5/18.
//  Copyright © 2018 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import LoggerKit
import SystemIntegrityKit

extension SystemIntegrityConfiguration {
    func printDetails(name: String) {
        Logger.log(important: "\(name) System Integrity Protection Configuration")
        Logger.log(info: "Raw Value: \(self)")
        
        for knownConfiguration in KnownConfiguration.allCases {
            let allowed = self.allows(configuration: knownConfiguration)
            
            if allowed {
                Logger.log(success: "\(knownConfiguration): \(allowed)")
            }
            else {
                Logger.log(warning: "\(knownConfiguration): \(allowed)")
            }
        }
    }
}

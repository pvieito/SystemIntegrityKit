//
//  SystemIntegrityManager.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 23/5/18.
//  Copyright © 2018 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import IOKit

public class SystemIntegrityManager {
    enum IORegistryError: LocalizedError {
        case invalidPath
        case errorReadingProperty
        case errorSettingProperty(Int32)
        
        var errorDescription: String? {
            switch self {
            case .invalidPath:
                return "IORegistry invalid path."
            case .errorReadingProperty:
                return "Error reading IORegistry property."
            case .errorSettingProperty(let errorCode):
                return "Error setting IORegistry property: \(errorCode)."
            }
        }
    }
    
    private static let nvramOptionsEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IODeviceTree:/options")
    private static let systemIntegrityPropertyName = "csr-active-config"
    
    public static func readCurrentConfiguration() throws -> SystemIntegrityConfiguration {
        guard nvramOptionsEntry != 0 else {
            throw IORegistryError.invalidPath
        }
        
        guard let unmanagedData = IORegistryEntryCreateCFProperty(
            nvramOptionsEntry, systemIntegrityPropertyName as CFString, kCFAllocatorDefault, 0),
            let data = unmanagedData.takeUnretainedValue() as? Data else {
                // NVRAM `csr-active-config` variable not set:
                return .default
        }
        
        let rawValue: UInt32 = data.withUnsafeBytes { $0.bindMemory(to: UInt32.self).baseAddress!.pointee }
        return SystemIntegrityConfiguration(rawValue: rawValue)
    }
    
    public static func setConfiguration(to systemIntegrityConfiguration: SystemIntegrityConfiguration) throws {
        guard nvramOptionsEntry != 0 else {
            throw IORegistryError.invalidPath
        }
        
        let result = IORegistryEntrySetCFProperty(
            nvramOptionsEntry,
            systemIntegrityPropertyName as CFString,
            systemIntegrityConfiguration.data as CFData)
        
        guard result == KERN_SUCCESS else {
            throw IORegistryError.errorSettingProperty(result)
        }
    }
}

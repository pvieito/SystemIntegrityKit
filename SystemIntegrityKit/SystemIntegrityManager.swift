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
        case errorSettingProperty(Int32)
        
        var errorDescription: String? {
            switch self {
            case .invalidPath:
                return "IORegistry invalid path."
            case .errorSettingProperty(let errorCode):
                return "Error setting the IORegistry property: \(errorCode)."
            }
        }
    }
    
    private static let nvramOptionsEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IODeviceTree:/options")
    private static let systemIntegrityPropertyName = "csr-active-config"
    
    public static var currentConfiguration: SystemIntegrityConfiguration {
        guard nvramOptionsEntry != 0 else {
            return .default
        }
        
        guard let unmanagedData = IORegistryEntryCreateCFProperty(nvramOptionsEntry,
                                        systemIntegrityPropertyName as CFString,
                                        kCFAllocatorDefault, 0) else {
                                            return .default
        }
        
        guard let data = unmanagedData.takeUnretainedValue() as? Data else {
            return .default
        }
        
        let rawValue: UInt32 = data.withUnsafeBytes { $0.pointee }
        return SystemIntegrityConfiguration(rawValue: rawValue)
    }
    
    public static func setConfiguration(to systemIntegrityConfiguration: SystemIntegrityConfiguration) throws {
        guard nvramOptionsEntry != 0 else {
            throw IORegistryError.invalidPath
        }
        
        let result = IORegistryEntrySetCFProperty(nvramOptionsEntry,
                                                  systemIntegrityPropertyName as CFString,
                                                  systemIntegrityConfiguration.data as CFData)
        
        guard result == KERN_SUCCESS else {
            throw IORegistryError.errorSettingProperty(result)
        }
    }
}

//
//  SystemIntegrityOption.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 30/12/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation

public struct SystemIntegrityConfiguration: OptionSet, CustomStringConvertible {
    
    public enum KnownConfiguration: UInt32, CaseIterable, CustomStringConvertible {
        case allowUntrustedKexts
        case allowUnrescrictedFilesystem
        case allowTaskForPID
        case allowKernelDebugger
        case allowAppleInternal
        case allowUnrestrictedDTrace
        case allowUnrestrictedNvram
        case allowDeviceConfiguration
        case allowAnyRecoveryOS
        case allowUnapprovedKexts
        
        public var rawValue: UInt32 {
            switch self {
            case .allowUntrustedKexts:
                return 1 << 0
            case .allowUnrescrictedFilesystem:
                return 1 << 1
            case .allowTaskForPID:
                return 1 << 2
            case .allowKernelDebugger:
                return 1 << 3
            case .allowAppleInternal:
                return 1 << 4
            case .allowUnrestrictedDTrace:
                return 1 << 5
            case .allowUnrestrictedNvram:
                return 1 << 6
            case .allowDeviceConfiguration:
                return 1 << 7
            case .allowAnyRecoveryOS:
                return 1 << 8
            case .allowUnapprovedKexts:
                return 1 << 9
            }
        }
        
        public var configuration: SystemIntegrityConfiguration {
            return SystemIntegrityConfiguration(rawValue: self.rawValue)
        }
        
        public var description: String {
            switch self {
            case .allowUntrustedKexts:
                return "Allow Untrusted Kexts"
            case .allowUnrescrictedFilesystem:
                return "Allow Unrescricted Filesystem"
            case .allowTaskForPID:
                return "Allow task_for_pid"
            case .allowKernelDebugger:
                return "Allow Kernel Debugger"
            case .allowAppleInternal:
                return "Allow Apple Internal"
            case .allowUnrestrictedDTrace:
                return "Allow Unrestricted DTrace"
            case .allowUnrestrictedNvram:
                return "Allow Unrestricted NVRAM"
            case .allowDeviceConfiguration:
                return "Allow Device Configuration"
            case .allowAnyRecoveryOS:
                return "Allow Any Recovery OS"
            case .allowUnapprovedKexts:
                return "Allow Unapproved Kexts"
            }
        }
    }
    
    public static let `default` = SystemIntegrityConfiguration(rawValue: 0)
    public static let unrestricted = SystemIntegrityConfiguration(rawValue: UInt32.max)
    
    public let rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    public init?(binaryConfiguration: String) {
        guard let rawValue = UInt32(binaryConfiguration, radix: 2) else {
            return nil
        }
        
        self.init(rawValue: rawValue)
    }
    
    public var description: String {
        return "0b" + String(self.rawValue, radix: 2)
    }
    
    internal var data: Data {
        var rawValue = self.rawValue
        return Data(buffer: UnsafeBufferPointer(start: &rawValue, count: 1))
    }
    
    public func allows(configuration: KnownConfiguration) -> Bool {
        return self.rawValue & configuration.rawValue != 0
    }
}

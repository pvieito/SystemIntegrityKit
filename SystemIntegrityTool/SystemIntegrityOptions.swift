//
//  SystemIntegrityOption.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 30/12/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation

struct SystemIntegrityConfiguration: OptionSet, CustomStringConvertible {
    let rawValue: UInt32
    
    static let allowUntrustedKexts          = SystemIntegrityConfiguration(rawValue: 1 << 0)
    static let allowUnrescrictedFilesystem  = SystemIntegrityConfiguration(rawValue: 1 << 1)
    static let allowTaskForPID              = SystemIntegrityConfiguration(rawValue: 1 << 2)
    static let allowKernelDebbuger          = SystemIntegrityConfiguration(rawValue: 1 << 3)
    static let allowAppleInternal           = SystemIntegrityConfiguration(rawValue: 1 << 4)
    static let allowUnrestrictedDtrace      = SystemIntegrityConfiguration(rawValue: 1 << 5)
    static let allowUnrestrictedNvram       = SystemIntegrityConfiguration(rawValue: 1 << 6)
    static let allowDeviceConfiguration     = SystemIntegrityConfiguration(rawValue: 1 << 7)
    static let allowAnyRecoveryOS           = SystemIntegrityConfiguration(rawValue: 1 << 8)
    static let allowUnapprovedKexts         = SystemIntegrityConfiguration(rawValue: 1 << 9)
    
    var description: String {
        return "0b" + String(self.rawValue, radix: 2)
    }
    
    var data: Data {
        var rawValue = self.rawValue
        return Data(buffer: UnsafeBufferPointer(start: &rawValue, count: 1))
    }
}

//
//  SystemIntegrityOption.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 30/12/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation

struct SystemIntegrityOptions: OptionSet, CustomStringConvertible {
    let rawValue: UInt32
    
    static let allowUntrustedKexts          = SystemIntegrityOptions(rawValue: 1 << 0)
    static let allowUnrescrictedFilesystem  = SystemIntegrityOptions(rawValue: 1 << 1)
    static let allowTaskForPID              = SystemIntegrityOptions(rawValue: 1 << 2)
    static let allowKernelDebbuger          = SystemIntegrityOptions(rawValue: 1 << 3)
    static let allowAppleInternal           = SystemIntegrityOptions(rawValue: 1 << 4)
    static let allowDestructiveDtrace       = SystemIntegrityOptions(rawValue: 1 << 5)
    static let allowUnrestrictedDtrace      = SystemIntegrityOptions(rawValue: 1 << 6)
    static let allowUnrestrictedNvram       = SystemIntegrityOptions(rawValue: 1 << 7)
    static let allowDeviceConfiguration     = SystemIntegrityOptions(rawValue: 1 << 8)
    static let allowAnyRecoveryOS           = SystemIntegrityOptions(rawValue: 1 << 9)
    
    var description: String {
        return String(self.rawValue, radix: 2)
    }
    
    var data: Data {
        var rawValue = self.rawValue
        return Data(buffer: UnsafeBufferPointer(start: &rawValue, count: 1))
    }
}

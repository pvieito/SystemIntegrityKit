//
//  main.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 2/7/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import IOKit

var systemIntegrityConfiguration: SystemIntegrityConfiguration

if CommandLine.arguments.count == 2 {
    let binaryConfiguration = CommandLine.arguments[1]
    guard let rawValueConfiguration = UInt32(binaryConfiguration, radix: 2) else {
        print("[x] Invalid input configuration “\(binaryConfiguration)”.")
        exit(-1)
    }
    
    systemIntegrityConfiguration = SystemIntegrityConfiguration(rawValue: rawValueConfiguration)
}
else {
    systemIntegrityConfiguration = [.allowUnrescrictedFilesystem,
                                    .allowTaskForPID,
                                    .allowKernelDebbuger,
                                    .allowAppleInternal,
                                    .allowUnrestrictedDtrace,
                                    .allowUnrestrictedNvram,
                                    .allowDeviceConfiguration]
}


print("[!] Setting System Integrity Protection with configuration “\(systemIntegrityConfiguration)”...")

let nvramOptionsEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IODeviceTree:/options")

guard nvramOptionsEntry != 0 else {
    print("[x] IORegistry invalid path.")
    exit(-1)
}

let systemIntegrityPropertyName = "csr-active-config"
let result = IORegistryEntrySetCFProperty(nvramOptionsEntry,
                                          systemIntegrityPropertyName as CFString,
                                          systemIntegrityConfiguration.data as CFData)

guard result == KERN_SUCCESS else {
    print("[x] Error setting the IORegistry property: \(result).")
    exit(-1)
}

print("[*] Success!")

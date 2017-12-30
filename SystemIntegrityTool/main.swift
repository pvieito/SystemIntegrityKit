//
//  main.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 2/7/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import IOKit

let systemIntegrityConfiguration: SystemIntegrityOptions = [.allowTaskForPID,
                                                           .allowKernelDebbuger,
                                                           .allowAppleInternal,
                                                           .allowDestructiveDtrace,
                                                           .allowUnrestrictedDtrace,
                                                           .allowUnrestrictedNvram]

print("Setting System Integrity Protection with configuration “\(systemIntegrityConfiguration)”...")

let nvramOptionsEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IODeviceTree:/options")

guard nvramOptionsEntry != 0 else {
    print("IORegistry invalid path.")
    exit(-1)
}

let systemIntegrityPropertyName = "csr-active-config"
let result = IORegistryEntrySetCFProperty(nvramOptionsEntry,
                                          systemIntegrityPropertyName as CFString,
                                          systemIntegrityConfiguration.data as CFData)

guard result == KERN_SUCCESS else {
    print("Error setting the IORegistry property: \(result).")
    exit(-1)
}

print("Success!")

//
//  main.swift
//  SystemIntegrityTool
//
//  Created by Pedro José Pereira Vieito on 2/7/17.
//  Copyright © 2017 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import IOKit

let entry = IORegistryEntryFromPath(kIOMasterPortDefault, "IODeviceTree:/options")

guard entry != 0 else {
    print("IORegistry invalid path.")
    exit(-1)
}

let noRestrictions = Data(bytes: [0xFF, 0x00, 0x00, 0x00])
let result = IORegistryEntrySetCFProperty(entry, "csr-active-config" as CFString, noRestrictions as CFData)

guard result == KERN_SUCCESS else {
    print("Error setting the IORegistry property: \(result).")
    exit(-1)
}

print("Success!")

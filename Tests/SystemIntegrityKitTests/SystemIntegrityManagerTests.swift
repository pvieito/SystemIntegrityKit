//
//  SystemIntegrityManagerTests.swift
//  SystemIntegrityKitTests
//
//  Created by Pedro José Pereira Vieito on 22/11/2019.
//  Copyright © 2019 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import SystemIntegrityKit
import XCTest

class SystemIntegrityManagerTests: XCTestCase {
    func testSystemIntegrityManager() throws {
        XCTAssertNoThrow(try SystemIntegrityManager.readCurrentConfiguration())
    }
}

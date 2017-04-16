//
//  CKHelper.swift
//  WWDCScholars
//
//  Created by Matthijs Logemann on 16/04/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation
import CloudKit

class CKHelper {
    
    static let sharedInstance: CKHelper = CKHelper()
    public let container: CKContainer
    public let publicDatabase: CKDatabase
    
    private init() {
        container = CKContainer(identifier: "iCloud.com.wwdcscholars.WWDCScholars")
        publicDatabase = container.publicCloudDatabase
    }
    
}

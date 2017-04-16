//
//  CloudKitItem.swift
//  WWDCScholars
//
//  Created by Matthijs Logemann on 16/04/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation
import CloudKit

public typealias SaveCompletionBlock = ((CKRecord, Error?) -> Swift.Void)?

protocol CloudKitItem {
    var id: CKRecordID { get set }
    
    init(record: CKRecord)
    
    func makeCKRecord() -> CKRecord
    
    func save(completion: SaveCompletionBlock)
}

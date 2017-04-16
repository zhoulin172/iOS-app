//
//  WWDCYear.swift
//  WWDCScholars
//
//  Created by Matthijs Logemann on 16/04/2017.
//
//

import Foundation
import CloudKit

class WWDCYear {
    let year: String
    let name: String
    
    private init() {
        self.year = ""
        self.name = ""
    }
    
    required init(record: CKRecord) throws {
        year = record["year"] as! String
        name = record["name"] as! String
    }
}


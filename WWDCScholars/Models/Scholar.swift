//
//  Scholar.swift
//  WWDCScholars
//
//  Created by Matthijs Logemann on 16/04/2017.
//  Copyright © 2017 Matthijs Logemann. All rights reserved.
//

import CloudKit
import Foundation

final class Scholar: CloudKitItem {
    var id: CKRecordID = CKRecordID(recordName: UUID.init().uuidString)
    
    // General
    public var firstName : String
    public var lastName : String
    public var email : String
    public var gender : String
    public var birthday : Date
    public var shortBio : String
    
    public var wwdcYears : [CKReference] = [] //-> WWDCYear
    public var wwdcYearInfos : [CKReference] = [] //-> WWDCYearInfo

    // Location
    public var location : CLLocation
    
    // URLs
    public var socialMediaReference: CKReference! //-> ScholarSocialMedia
    
    // Useful dates
    public fileprivate(set) var createdAt : Date
//    public fileprivate(set) var updatedAt : Date
    public var approvedOn : Date
    
    // Status
    //    public var statusComment : String?
    public var status : Status
    
    // Authentication
    public var password : String?
    
    init() {
        location = CLLocation.init(latitude: 0, longitude: 0)
        shortBio = ""
        
        let socialMedia = ScholarSocialMedia.init()
        socialMedia.itunes = nil
        socialMedia.website = nil
        socialMedia.linkedin = nil
        socialMedia.github = nil
        socialMedia.facebook = nil
        socialMedia.imessage = nil
        socialMedia.twitter = nil
        
        gender = ""
        birthday = Date()
        email = ""
        lastName = ""
        firstName = ""
        createdAt = Date()
        
        status = .pending
        approvedOn = Date()
        password = ""
    }
    
    init(record: CKRecord) {
        id = record.recordID
        location = record["location"] as! CLLocation
        shortBio = record["shortBio"] as! String
        socialMediaReference = record["socialMedia"] as! CKReference
        gender = record["gender"] as! String
        birthday = record["birthday"] as! Date
        email = record["email"] as! String
        lastName = record["lastName"] as! String
        firstName = record["firstName"] as! String
        createdAt = record["creationDate"] as! Date
        wwdcYears = record["wwdcYears"] as! [CKReference]
        wwdcYearInfos = record["wwdcYearInfos"] as! [CKReference]
//        updatedAt = record["updatedAt"] as! Date
        //        statusComment = try node.extract("statusComment")
        status = Scholar.Status(rawValue: record["status"] as! String)!
        
        approvedOn = record["approvedOn"] as! Date
//        password = record["password"] as! String
    }
    
    func makeCKRecord() -> CKRecord {
        let record = CKRecord.init(recordType: "Scholar", recordID: id)
        record["shortBio"] = self.shortBio as NSString
        record["socialMedia"] = self.socialMediaReference as CKReference
        
        record["location"] = self.location
        record["gender"] = self.gender as NSString
        record["birthday"] = self.birthday as NSDate
        record["email"] = self.email as NSString
        record["lastName"] = self.lastName as NSString
        record["firstName"] = self.firstName as NSString
        
        record["status"] = self.status.rawValue as NSString
        record["approvedOn"] = self.approvedOn as NSDate

        record["wwdcYearInfos"] = self.wwdcYearInfos as NSArray
        record["wwdcYears"] = self.wwdcYears as NSArray
        
        return record
    }
    
    func save(completion: SaveCompletionBlock = nil) {
        let saveRecordsOperation = CKModifyRecordsOperation()
        saveRecordsOperation.recordsToSave = [self.makeCKRecord()]
        saveRecordsOperation.savePolicy = .changedKeys
        saveRecordsOperation.perRecordCompletionBlock = { (record, error) in
            completion?(record, error)
        }
        saveRecordsOperation.completionBlock = {
            print ("Done")
        }
        CKHelper.sharedInstance.publicDatabase.add(saveRecordsOperation)
    }
}

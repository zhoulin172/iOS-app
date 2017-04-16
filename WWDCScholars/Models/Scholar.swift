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
    
    public var batchWWDC : [CKReference] = [] //WWDCItem
    
    // Location
    public var location : CLLocation
    
    // URLs
    public var imessage : String?
    public var itunes : String?
    public var website : String?
    public var linkedin : String?
    public var github : String?
    public var facebook : String?
    public var twitter : String?
    
    // Useful dates
    public fileprivate(set) var createdAt : Date
    public fileprivate(set) var updatedAt : Date
    public var approvedOn : Date
    
    // Status
    //    public var statusComment : String?
    public var status : Status
    
    // Authentication
    public var password : String?
    
    init() {
        location = CLLocation.init(latitude: 0, longitude: 0)
        shortBio = ""
        itunes = nil
        website = nil
        linkedin = nil
        github = nil
        facebook = nil
        imessage = nil
        twitter = nil
        
        gender = ""
        birthday = Date()
        email = ""
        lastName = ""
        firstName = ""
        createdAt = Date()
        batchWWDC = []
        updatedAt = Date()
        
        status = .pending
        approvedOn = Date()
        password = ""
    }
    
    init(record: CKRecord) throws {
        id = record.recordID
        location = record["location"] as! CLLocation
        shortBio = record["shortBio"] as! String
        itunes = record["itunes"] as? String
        website = record["website"] as? String
        linkedin = record["linkedin"] as? String
        github = record["github"] as? String
        facebook = record["facebook"] as? String
        imessage = record["imessage"] as? String
        twitter = record["twitter"] as? String
        gender = record["gender"] as! String
        birthday = record["birthday"] as! Date
        email = record["email"] as! String
        lastName = record["lastName"] as! String
        firstName = record["firstName"] as! String
        createdAt = record["createdAt"] as! Date
        batchWWDC = record["batchWWDC"] as! [CKReference]
        updatedAt = record["updatedAt"] as! Date
        //        statusComment = try node.extract("statusComment")
        status = record["status"] as! Scholar.Status
        
        approvedOn = record["approvedOn"] as! Date
//        password = record["password"] as! String
    }
    
    func makeCKRecord() -> CKRecord {
        let record = CKRecord.init(recordType: "Scholar", recordID: id)
        record["shortBio"] = self.shortBio as NSString
        record["itunes"] = self.itunes as NSString?
        record["website"] = self.website as NSString?
        record["linkedin"] = self.linkedin as NSString?
        record["github"] = self.github as NSString?
        record["facebook"] = self.facebook as NSString?
        record["twitter"] = self.twitter as NSString?
        record["imessage"] = self.imessage as NSString?
        
        record["location"] = self.location
        record["gender"] = self.gender as NSString
        record["birthday"] = self.birthday as NSDate
        record["email"] = self.email as NSString
        record["lastName"] = self.lastName as NSString
        record["firstName"] = self.firstName as NSString
        
        record["status"] = self.status.rawValue as NSString
        record["approvedOn"] = self.approvedOn as NSDate

        record["batchWWDC"] = self.batchWWDC as NSArray
        
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

//
//  ScholarSocialMedia.swift
//  WWDCScholars
//
//  Created by Matthijs Logemann on 16/04/2017.
//
//

import Foundation
import CloudKit

class ScholarSocialMedia {
    var id: CKRecordID = CKRecordID(recordName: UUID.init().uuidString)
    
    public var imessage : String?
    public var itunes : String?
    public var website : String?
    public var linkedin : String?
    public var github : String?
    public var facebook : String?
    public var twitter : String?
    
    init() {
    
    }
    
    required init(record: CKRecord) throws {
        id = record.recordID
        imessage = record["imessage"] as! String?
        itunes = record["itunes"] as! String?
        website = record["website"] as! String?
        linkedin = record["linkedin"] as! String?
        github = record["github"] as! String?
        facebook = record["facebook"] as! String?
        twitter = record["twitter"] as! String?
    }
    
    func makeCKRecord() -> CKRecord {
        let record = CKRecord.init(recordType: "ScholarSocialMedia", recordID: id)
        record["imessage"] = self.imessage as NSString?
        record["itunes"] = self.itunes as NSString?
        record["website"] = self.website as NSString?
        record["linkedin"] = self.linkedin as NSString?
        record["github"] = self.github as NSString?
        record["facebook"] = self.facebook as NSString?
        record["twitter"] = self.twitter as NSString?
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


//
//  WWDCItem.swift
//  WWDCScholars-Backend
//
//  Created by Matthijs Logemann on 18/01/2017.
//
//

import Foundation
import CloudKit

class WWDCItem: CloudKitItem {
    var id: CKRecordID = CKRecordID(recordName: UUID.init().uuidString)
    
    let year: String
    let profilePicture: String
    let acceptanceEmail: String?
    let videoLink: String?
    let screenshots: [CKAsset] //Screenshots
    let githubAppLink: String?

    let appType: String
    let appStoreSubmissionLink: String?
    
    // student/stem/both
    let appliedAs: String
    
    init(year: String, profilePicture: String, acceptanceEmail: String?, screenshots: [CKAsset], videoLink: String?, githubAppLink: String?, appType: String, appStoreSubmissionLink: String?, appliedAs: String) {
        self.year = year
        self.profilePicture = profilePicture
        self.acceptanceEmail = acceptanceEmail
        self.screenshots = screenshots
        self.videoLink = videoLink
        self.githubAppLink = githubAppLink
        self.appType = appType
        self.appStoreSubmissionLink = appStoreSubmissionLink
        self.appliedAs = appliedAs
    }
    
    required init(record: CKRecord) throws {
        year = record["year"] as! String
        profilePicture = record["profilePicture"] as! String
        acceptanceEmail = record["acceptanceEmail"] as! String?
        screenshots = record["screenshots"] as! [CKAsset]
        videoLink = record["videoLink"] as! String?
        githubAppLink = record["githubAppLink"] as! String?
        appType = record["appType"] as! String
        appStoreSubmissionLink = record["appStoreSubmissionLink"] as! String?
        appliedAs = record["appliedAs"] as! String
    }
    
    func makeCKRecord() -> CKRecord {
        let record = CKRecord.init(recordType: "WWDCItem", recordID: id)
        record["year"] = self.year as NSString
        record["profilePicture"] = self.profilePicture as NSString
        record["acceptanceEmail"] = self.acceptanceEmail as NSString?
        record["screenshots"] = self.screenshots as NSArray
        record["videoLink"] = self.videoLink as NSString?
        record["githubAppLink"] = self.githubAppLink as NSString?
        record["appType"] = self.appType as NSString
        record["appStoreSubmissionLink"] = self.appStoreSubmissionLink as NSString?
        
        record["appliedAs"] = self.appliedAs as NSString
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


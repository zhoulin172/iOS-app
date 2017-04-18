//
//  WWDCItem.swift
//  WWDCScholars
//
//  Created by Matthijs Logemann on 18/01/2017.
//
//

import Foundation
import CloudKit

class WWDCYearInfo: CloudKitItem {
    var id: CKRecordID = CKRecordID(recordName: UUID.init().uuidString)
    
    var scholarReference: CKReference
    var yearReference: CKReference
    
    let profilePicture: CKAsset
    let acceptanceEmail: CKAsset?
    let videoLink: String?
    let screenshots: [CKAsset] //Screenshots
    let githubAppLink: String?

    let appType: String
    let appStoreSubmissionLink: String?
    
    // student/stem/both
    let appliedAs: String
    
    init(for scholarRecordId: CKRecordID, yearReference: CKRecordID, profilePicture: CKAsset, acceptanceEmail: CKAsset?, screenshots: [CKAsset], videoLink: String?, githubAppLink: String?, appType: String, appStoreSubmissionLink: String?, appliedAs: String) {
        self.scholarReference = CKReference.init(recordID: scholarRecordId, action: .none)
        self.yearReference = CKReference.init(recordID: scholarRecordId, action: .none)
        self.profilePicture = profilePicture
        self.acceptanceEmail = acceptanceEmail
        self.screenshots = screenshots
        self.videoLink = videoLink
        self.githubAppLink = githubAppLink
        self.appType = appType
        self.appStoreSubmissionLink = appStoreSubmissionLink
        self.appliedAs = appliedAs
    }
    
    required init(record: CKRecord) {
        scholarReference  = record["scholar"] as! CKReference
        yearReference = record["year"] as! CKReference
        profilePicture = record["profilePicture"] as! CKAsset
        acceptanceEmail = record["acceptanceEmail"] as! CKAsset?
        screenshots = record["screenshots"] as! [CKAsset]
        videoLink = record["videoLink"] as! String?
        githubAppLink = record["githubAppLink"] as! String?
        appType = record["appType"] as! String
        appStoreSubmissionLink = record["appStoreSubmissionLink"] as! String?
        appliedAs = record["appliedAs"] as! String
    }
    
    func makeCKRecord() -> CKRecord {
        let record = CKRecord.init(recordType: "WWDCYearInfo", recordID: id)
        record["scholar"] = self.scholarReference
        record["year"] = self.yearReference
        record["profilePicture"] = self.profilePicture as CKAsset
        record["acceptanceEmail"] = self.acceptanceEmail as CKAsset?
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


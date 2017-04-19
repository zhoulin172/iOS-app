//
//  AppDelegate.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 13/04/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import UIKit
import CloudKit

@UIApplicationMain
internal final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Internal Properties
    
    internal var window: UIWindow?

    // MARK: - Internal Functions
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIStatusBar.applyScholarsLightStyle()
        UINavigationBar.applyScholarsStyle()
        UITabBar.applyScholarsStyle()
        
//        let testScholar = Scholar.init()
//        testScholar.location = CLLocation.init(latitude: 52.062226, longitude: 5.372548)
//        testScholar.shortBio = "Hi this is my short bio"
//        
//        let socialMedia = ScholarSocialMedia.init()
//        socialMedia.itunes = "https://itunes.apple.com"
//        socialMedia.website = "logicbit.nl"
//        socialMedia.linkedin = "linkedin.com"
//        socialMedia.github = "github.com"
//        socialMedia.facebook = "facebook.com"
//        socialMedia.imessage = "matthijs@logicbit.nl"
//        socialMedia.twitter = "https://twitter.com"
//        socialMedia.save()
//        testScholar.socialMediaReference = CKReference(recordID: socialMedia.id, action: .deleteSelf)
//        testScholar.gender = "male"
//        testScholar.birthday = Date.init(timeIntervalSince1970: 925171200)
//        testScholar.email = "matthijs@logicbit.nl"
//        testScholar.lastName = "Logika"
//        testScholar.firstName = "Matthijs"
//        testScholar.wwdcYearInfos = []
//        //        statusComment = ""
//        testScholar.status = .pending
//        testScholar.approvedOn = Date()
//        testScholar.password = "Password"
//        
//        
//        let path = AppDelegate.createLocalUrl(forImageNamed: "IMG_1817")!
//        let wwdcItem = WWDCYearInfo.init(for: testScholar.id, yearReference: CKRecordID.init(recordName: "WWDC 2017"), profilePicture: "https://google.com", acceptanceEmail: "Acceptance", screenshots: [CKAsset.init(fileURL: path)], videoLink: "Video", githubAppLink: "Github", appType: "both", appStoreSubmissionLink: "none", appliedAs: "scholar")
//        testScholar.wwdcYearInfos = [CKReference.init(recordID: wwdcItem.id, action: .deleteSelf)]
//        testScholar.wwdcYears = [CKReference.init(recordID: CKRecordID.init(recordName: "WWDC 2017"), action: .none)]
//
//        wwdcItem.save() { item, err in
//            print (err)
//        }
//        
//        testScholar.save(){ item, err in
//            print (err)
//        }
//
//        let lastYearItems = CKQuery.init(recordType: "WWDCItem", predicate: NSPredicate.init(format: "year == '2017'"))
//        
//        CKHelper.sharedInstance.publicDatabase.perform(lastYearItems, inZoneWith: nil) { (item, error) in
//            print (item)
//            print (error)
//        }
        
        CKHelper.sharedInstance.container.requestApplicationPermission(.userDiscoverability) { (status, error) in
            CKHelper.sharedInstance.container.fetchUserRecordID { (record, error) in
                CKHelper.sharedInstance.publicDatabase.fetch(withRecordID: record!, completionHandler: { (rec, error) in
                    let schol = rec!["scholar"] as? CKReference
                    
                    if schol == nil {
                        CKHelper.sharedInstance.container.discoverUserIdentity(withUserRecordID: record!, completionHandler: { (userID, error) in
//                            print(userID?.hasiCloudAccount)
//                            print(userID?.lookupInfo?.phoneNumber)
//                            print(userID?.lookupInfo?.emailAddress)
                            
                            print("Looking up scholar with name" + (userID?.nameComponents?.givenName)! + " " + (userID?.nameComponents?.familyName)!)
                            let query = CKQuery.init(recordType: "Scholar", predicate: NSPredicate.init(format: "firstName = '\((userID?.nameComponents?.givenName)!)' AND lastName = '\((userID?.nameComponents?.familyName)!)'"))
                            CKHelper.sharedInstance.publicDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, errror) in
                                print (records)
                                if records?.count == 1 {
                                    rec!["scholar"] = CKReference.init(recordID: records![0].recordID, action: .none)
                                    let saveRecordsOperation = CKModifyRecordsOperation()
                                    saveRecordsOperation.recordsToSave = [rec!]
                                    saveRecordsOperation.savePolicy = .changedKeys
                                    saveRecordsOperation.perRecordCompletionBlock = { (record, error) in
//                                        completion?(record, error)
                                    }
                                    saveRecordsOperation.completionBlock = {
                                        print ("Done")
                                    }
                                    CKHelper.sharedInstance.publicDatabase.add(saveRecordsOperation)
                                }
                            })
                        })
                    }
                    print (schol)
                })
                
            }
        }
        
        return true
    }

    static func createLocalUrl(forImageNamed name: String) -> URL? {
        
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        
        guard fileManager.fileExists(atPath: url.path) else {
            guard
                let image = UIImage(named: name),
                let data = UIImagePNGRepresentation(image)
                else { return nil }
            
            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }
        
        return url
    }
    
    internal func applicationWillResignActive(_ application: UIApplication) {
    }

    internal func applicationDidEnterBackground(_ application: UIApplication) {
    }

    internal func applicationWillEnterForeground(_ application: UIApplication) {
    }

    internal func applicationDidBecomeActive(_ application: UIApplication) {
    }

    internal func applicationWillTerminate(_ application: UIApplication) {
    }
}

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
//        testScholar.itunes = "https://itunes.apple.com"
//        testScholar.website = "logicbit.nl"
//        testScholar.linkedin = "linkedin.com"
//        testScholar.github = "github.com"
//        testScholar.facebook = "facebook.com"
//        testScholar.imessage = "matthijs@logicbit.nl"
//        testScholar.twitter = "https://twitter.com"
//        
//        testScholar.gender = "male"
//        testScholar.birthday = Date.init(timeIntervalSince1970: 925171200)
//        testScholar.email = "matthijs@logicbit.nl"
//        testScholar.lastName = "Logika"
//        testScholar.firstName = "Matthijs"
//        testScholar.batchWWDC = []
//        //        statusComment = ""
//        testScholar.status = .pending
//        testScholar.approvedOn = Date()
//        testScholar.password = "Password"
//        
//        
//        let path = AppDelegate.createLocalUrl(forImageNamed: "IMG_1817")!
//        let wwdcItem = WWDCItem.init(year: "2017", profilePicture: "https://google.com", acceptanceEmail: "Acceptance", screenshots: [CKAsset.init(fileURL: path)], videoLink: "Video", githubAppLink: "Github", appType: "both", appStoreSubmissionLink: "none", appliedAs: "scholar")
//        testScholar.batchWWDC = [CKReference.init(recordID: wwdcItem.id, action: .deleteSelf)]
//        
//        wwdcItem.save() { item, err in
//            print (err)
//        }
//        
//        testScholar.save(){ item, err in
//            print (err)
//        }

        let lastYearItems = CKQuery.init(recordType: "WWDCItem", predicate: NSPredicate.init(format: "year == '2017'"))
        
        CKHelper.sharedInstance.publicDatabase.perform(lastYearItems, inZoneWith: nil) { (item, error) in
            print (item)
            print (error)
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

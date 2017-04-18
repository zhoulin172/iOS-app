//
//  ScholarsViewController.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 14/04/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

internal final class ScholarsViewController: UIViewController, UICollectionViewDataSource {
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var navigationBarExtensionView: NavigationBarExtensionView?
    @IBOutlet private weak var batchCollectionView: UICollectionView!
    @IBOutlet private weak var scholarCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        self.styleUI()
        self.configureUI()
        self.fetchDataFromServer()
    }
    
    // MARK: - UI
    
    private func styleUI() {
        self.view.applyBackgroundStyle()
        self.navigationBarExtensionView?.backgroundColor = .scholarsPurple
    }
    
    private func configureUI() {
        self.title = "Scholars"
        self.navigationController?.navigationBar.applyExtendedStyle()
        
        self.scholarCollectionView.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource
    var scholars: [Scholar] = []
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scholars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard collectionView == scholarCollectionView else {
            return UICollectionViewCell()
        }
        
        let scholarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScholarCollectionViewCell", for: indexPath) as! ScholarCollectionViewCell
        scholarCell.backgroundColor = .scholarsPurple
        let scholar = scholars[indexPath.row]
        scholarCell.nameLabel.text = scholar.firstName
        scholarCell.profilePictureImageView.image = nil
        CKHelper.sharedInstance.publicDatabase.fetch(withRecordID: scholar.wwdcYearInfos.last!.recordID) { obj, err in
            if err != nil {
                print (err)
                return
            }
            let info = WWDCYearInfo.init(record: obj!)
            DispatchQueue.main.async {
            scholarCell.profilePictureImageView.image = info.profilePicture.image()
            }
        }
        return scholarCell
    }
    
    func fetchDataFromServer() {
        let ref = CKReference.init(recordID: CKRecordID.init(recordName: "WWDC 2016"), action: .none)
        let pred = NSPredicate.init(format: "wwdcYears contains %@ AND status == 'approved'", ref)
        let query = CKQuery(recordType: "Scholar", predicate: pred)
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 35
        
        var newScholars = [Scholar]()
        operation.recordFetchedBlock = { record in
            let scholar = Scholar.init(record: record)
            newScholars.append(scholar)
        }
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.scholars = newScholars
                    self.scholarCollectionView.reloadData()
                } else {
                    let ac = UIAlertController(title: "Fetch failed", message: "There was a problem fetching the list of scholars; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
        CKHelper.sharedInstance.publicDatabase.add(operation)
    }
}

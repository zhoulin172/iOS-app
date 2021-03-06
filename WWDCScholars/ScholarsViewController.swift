//
//  ScholarsViewController.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 14/04/2017.
//  Copyright © 2017 WWDCScholars. All rights reserved.
//

import Foundation
import UIKit
import CloudKit.CKRecordID

internal final class ScholarsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var navigationBarExtensionView: NavigationBarExtensionView?
    @IBOutlet private weak var batchCollectionView: UICollectionView?
    @IBOutlet private weak var scholarsMapContainerView: ScholarsMapContainerView?
    @IBOutlet private weak var scholarsListContainerView: ScholarsListContainerView?
    
    private let batchCollectionViewContentController = CollectionViewContentController()
    
    private var scholarsMapViewController: ScholarsMapViewController?
    private var scholarsListViewController: ScholarsListViewController?
    private var containerViewSwitchHelper: ContainerViewSwitchHelper?
    private var batches: [WWDCYear] = [.wwdc2013, .wwdc2014, .wwdc2015, .wwdc2016, .wwdc2017, .wwdc2018, .saved]
    
    // MARK: - File Private Properties
    
    fileprivate var scholars = [Scholar]()
    
    // MARK: - Internal Properties
    
    internal var proxy: ScholarsViewControllerProxy?
    
    // MARK: - Lifecycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        let scholarsListContainerViewContent = ContainerViewElements(view: self.scholarsListContainerView, viewController: self.scholarsListViewController)
        let scholarsMapContainerViewContent = ContainerViewElements(view: self.scholarsMapContainerView, viewController: self.scholarsMapViewController)
        self.containerViewSwitchHelper = ContainerViewSwitchHelper(activeContainerViewElements: scholarsListContainerViewContent, inactiveContainerViewElements: scholarsMapContainerViewContent)
        
        self.proxy = ScholarsViewControllerProxy(delegate: self)
        
        self.styleUI()
        self.configureUI()
        self.configureBatchContentController()
        self.selectDefaultBatch()
        self.scrollToSelectedBatch()
        self.checkForIntroSeenYet()
    }
    
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "ScholarsListViewController" {
            let scholarsListViewController = segue.destination as? ScholarsListViewController
            scholarsListViewController?.scholars = self.scholars
            self.scholarsListViewController = scholarsListViewController
            return
        }
        
        if segue.identifier == "ScholarsMapViewController" {
            let scholarsMapViewController = segue.destination as? ScholarsMapViewController
            scholarsMapViewController?.scholars = self.scholars
            self.scholarsMapViewController = scholarsMapViewController
            return
        }
        
        if segue.identifier == "ProfileViewController" {
            let scholarProfileViewController = segue.destination as? ProfileViewController
//            scholarProfileViewController?.scholarId = sender as? CKRecordID
            return
        }
    }
    
    // MARK: - UI
    
    private func styleUI() {
        self.view.applyBackgroundStyle()
        self.navigationController?.navigationBar.applyExtendedStyle()
        self.navigationBarExtensionView?.backgroundColor = .scholarsPurple
    }
    
    private func configureUI() {
        self.title = "Scholars"
    }
    
    private func showIntro() {
        let storyboard = UIStoryboard.init(name: "Intro", bundle: nil)
        let intro = storyboard.instantiateInitialViewController()!
        self.present(intro, animated: true, completion: nil)
    }
    
    // MARK: - Internal Functions
    
    internal func selectSavedBatch() {
        self.batchCollectionViewContentController.selectSavedBatch()
    }
    
    internal func scrollToSelectedBatch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.batchCollectionViewContentController.scrollToSelectedBatch()
        })
    }
    
    internal func checkForIntroSeenYet(){
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "userHasSeen2018Intro") == true{
            
        }else{
            userDefaults.set(true, forKey: "userHasSeen2018Intro")
            showIntro()
        }
    }
    
    // MARK: - File Private Functions
    
    fileprivate func updateContainerViewsContent() {
        self.scholarsListViewController?.scholars = self.scholars
        self.scholarsListViewController?.configureScholarContentController()
        self.scholarsMapViewController?.scholars = self.scholars
        self.scholarsMapViewController?.configureMapContent()
    }
    
    // MARK: - Private Functions
    
    private func configureBatchContentController() {
        self.batchCollectionViewContentController.configure(collectionView: self.batchCollectionView)
        
        let batchSectionContent = ScholarsViewControllerCellContentFactory.batchSectionContent(from: self.batches, delegate: self)
        
        self.batchCollectionViewContentController.add(sectionContent: batchSectionContent)
        self.batchCollectionViewContentController.reloadContent()
    }
    
    private func selectDefaultBatch() {
        self.batchCollectionViewContentController.selectDefaultBatch()
    }
    
    // MARK: - Actions
    
    @IBAction internal func switchViewButtonTapped() {
        self.containerViewSwitchHelper?.switchViews()
        
        let rightBarButtonItemImage = (self.containerViewSwitchHelper?.inactiveContainerViewElements?.view as? ScholarsSwitchableContainerView)?.navigationBarItemImage
        self.navigationItem.rightBarButtonItem?.image = rightBarButtonItemImage
    }
}

extension ScholarsViewController: ScholarsViewControllerProxyDelegate {

    // MARK: - Internal Functions
    internal func didLoad(basicScholar: Scholar) {
		scholars.append(basicScholar)
    }
    
    internal func didLoadBatch() {
        self.updateContainerViewsContent()
    }
}

extension ScholarsViewController: BatchCollectionViewCellContentDelegate {
    
    // MARK: - Internal Functions
    
    internal func update(for batchInfo: WWDCYear) {
		self.scholars = []
        self.proxy?.loadListScholars(batchInfo: batchInfo)
    }
}

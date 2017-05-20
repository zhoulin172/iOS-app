//
//  ScholarsViewController.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 14/04/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation
import UIKit

internal final class ScholarsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var navigationBarExtensionView: NavigationBarExtensionView?
    @IBOutlet private weak var batchCollectionView: UICollectionView?
    @IBOutlet private weak var scholarCollectionView: UICollectionView?
    
    private let batchCollectionViewContentController = CollectionViewContentController()
    private let scholarCollectionViewContentController = CollectionViewContentController()
    
    // MARK: - Lifecycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        self.styleUI()
        self.configureUI()
        self.configureBatchContentController()
        self.configureScholarContentController()
    }
    
    // MARK: - UI
    
    private func styleUI() {
        self.view.applyBackgroundStyle()
        self.navigationBarExtensionView?.backgroundColor = .scholarsPurple
    }
    
    private func configureUI() {
        self.title = "Scholars"
        self.navigationController?.navigationBar.applyExtendedStyle()
    }
    
    // MARK: - Private Functions
    
    private func configureBatchContentController() {
        self.batchCollectionViewContentController.configure(collectionView: self.batchCollectionView)
        
        let batches: [BatchInfo] = [BatchInfo2013(), BatchInfo2014(), BatchInfo2015(), BatchInfo2016(), BatchInfo2016()]
        let batchesSectionContent = ScholarsViewControllerCellContentFactory.batchesSectionContent(from: batches)
        
        self.batchCollectionViewContentController.add(sectionContent: batchesSectionContent)
        self.batchCollectionViewContentController.reloadContent()
    }
    
    private func configureScholarContentController() {
        self.scholarCollectionViewContentController.configure(collectionView: self.scholarCollectionView)
        
        let scholars: [ExampleScholar] = [ScholarOne(), ScholarOne(), ScholarOne(), ScholarOne(), ScholarOne(), ScholarOne(), ScholarOne()]
        let scholarSectionContent = ScholarsViewControllerCellContentFactory.scholarSectionContent(from: scholars)
        
        self.scholarCollectionViewContentController.add(sectionContent: scholarSectionContent)
        self.scholarCollectionViewContentController.reloadContent()
    }
}

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
    
    // MARK: - Lifecycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        self.styleUI()
        self.configureUI()        
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
    
}

extension ScholarsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let scholarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScholarCell", for: indexPath)
        
        return scholarCell
    }
}

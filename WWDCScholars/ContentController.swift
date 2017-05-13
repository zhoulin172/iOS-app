//
//  ContentController.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 11/05/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation

internal protocol ContentController: class {
    var sectionContent: [SectionContent] { get set }

    func reloadContent()
    func add(sectionContent: SectionContent)
    func add(sectionContent: [SectionContent])
    func removeAllContent()
}

internal extension ContentController {

    // MARK: - internal Functions

    internal func numberOfSections() -> Int {
        return self.sectionContent.count
    }

    internal func numberOfItems(in section: Int) -> Int {
        return self.sectionContent[section].cellContent.count
    }

    internal func reuseIdentifier(for indexPath: IndexPath) -> String {
        return self.sectionContent[indexPath.section].cellContent[indexPath.item].reuseIdentifier
    }

    internal func cellContent(for indexPath: IndexPath) -> CellContent {
        return self.sectionContent[indexPath.section].cellContent[indexPath.row]
    }

    internal func add(sectionContent: SectionContent) {
        self.sectionContent.append(sectionContent)
    }

    internal func add(sectionContent: [SectionContent]) {
        self.sectionContent.append(contentsOf: sectionContent)
    }

    internal func removeAllContent() {
        self.sectionContent.removeAll()
    }
}
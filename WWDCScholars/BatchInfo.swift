//
//  BatchInfo.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 12/05/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation

internal protocol BatchInfo {
    var title: String { get }
}

internal struct BatchInfo2013: BatchInfo {
    
    // MARK: - Internal Properties
    
    internal let title = "2013"
}

internal struct BatchInfo2014: BatchInfo {
    
    // MARK: - Internal Properties
    
    internal let title = "2014"
}

internal struct BatchInfo2015: BatchInfo {
    
    // MARK: - Internal Properties
    
    internal let title = "2015"
}

internal struct BatchInfo2016: BatchInfo {
    
    // MARK: - Internal Properties
    
    internal let title = "2016"
}

internal struct BatchInfo2017: BatchInfo {
    
    // MARK: - Internal Properties
    
    internal let title = "2017"
}

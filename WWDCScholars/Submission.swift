//
//  Submission.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 19/05/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation
import CloudKit

internal protocol Submission {
    var gitHubLink: String? { get }
    var videoLink: String? { get }
}

internal struct AppSubmission: Submission {
    internal let screenshots: [CKAsset]
    internal let gitHubLink: String?
    internal let videoLink: String?
}

internal struct AppStoreSubmission: Submission {
    internal let appStoreID: String
    internal let gitHubLink: String?
    internal let videoLink: String?
}

internal struct PlaygroundSubmission: Submission {
    internal let screenshots: [CKAsset]
    internal let gitHubLink: String?
    internal let videoLink: String?
}

//
//  Scholar.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 19/05/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation
import CoreLocation
import CloudKit

internal protocol Scholar {
    var profileImage: CKAsset { get }
    var firstName: String { get }
    var secondName: String { get }
    var gender: Gender { get }
    var birthday: Date { get }
    var location: CLLocation { get }
    
    var email: String { get }
    var shortBio: String { get }
    var socialMedia: SocialMedia { get }
    var batches: [Batch] { get }
}

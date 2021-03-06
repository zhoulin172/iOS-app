//
//  Scholar.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 08/05/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation
import CoreLocation

/**
 Model which represents a scholar in the app
 */
internal class Scholar {
    /** The unique id of the scholar */
    var id: UUID
	
    /** The first name of the scholar */
    var firstName: String
    
    /** The last name of the scholar */
    var lastName: String
    
    /** The gender of the scholar */
    var gender: Gender
    
    /** The birthday of the scholar */
    var birthday: Date
    
    /** The location of the scholar */
    var location: CLLocation
    
    /** The email address of the scholar */
    var email: String
    /** The short biography of the scholar */
    var shortBio: String
    
    /** The id of the social media object belonging to this scholar */
    var socialMediaId: UUID

    /** The list of (submission) information per WWDC */
    var yearInfo: [WWDCYear : UUID]
    
    /** The current status of the Scholar */
    var status : Status
    
    /** The date when the Scholar got approved */
    var approvedOn: Date?

    /** The date when the Scholar got created */
    var createdAt: Date
    
    /** The url to the scholar profile picture of this scholar */
    var profilePictureUrl: URL
    
    /** Convenience variable to return the full name of the scholar */
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    /// Constructor to get an instance of a scholar using a dictionary with data
    ///
    /// - Parameter record: A dictionary containing the information of the scholar
    init?(record: [String: Any]) {
        guard
            let id                = record["id"] as? UUID,
            let creationDate      = record["creationDate"] as? Date,
            let location          = record["location"] as? CLLocation,
            let shortBio          = record["shortBio"] as? String,
            let gender            = record["gender"] as? Gender,
            let birthday          = record["birthday"] as? Date,
            let email             = record["email"] as? String,
            let firstName         = record["firstName"] as? String,
            let lastName          = record["lastName"] as? String,
            let profilePictureUrl = record["profilePictureUrl"] as? URL,
            let socialMedia       = record["socialMedia"] as? UUID,
            let yearInfo          = record["yearInfo"] as? [WWDCYear : UUID],
            let status            = record["status"] as? Status else {
                return nil
        }
        
        // Non-optional variables
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.birthday = birthday
        self.location = location
        self.email = email
        self.socialMediaId = socialMedia
        self.shortBio = shortBio
        self.yearInfo = yearInfo
        self.status = status
        self.profilePictureUrl = profilePictureUrl
        self.createdAt = creationDate
        
        // Optional values
        self.approvedOn = record["approvedOn"] as? Date
    }
}

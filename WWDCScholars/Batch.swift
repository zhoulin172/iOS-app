//
//  Batch.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 19/05/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation

internal protocol Batch {
    var submissions: [Submission] { get }
    var applicantType: ApplicantType { get }
}

internal struct Batch2013: Batch {
    internal let submissions: [Submission] = []
    internal let applicantType: ApplicantType = .education
}

internal struct Batch2014: Batch {
    internal let submissions: [Submission] = []
    internal let applicantType: ApplicantType = .education
}

internal struct Batch2015: Batch {
    internal let submissions: [Submission]
    internal let applicantType: ApplicantType
}

internal struct Batch2016: Batch {
    internal let submissions: [Submission]
    internal let applicantType: ApplicantType
}

internal struct Batch2017: Batch {
    internal let submissions: [Submission]
    internal let applicantType: ApplicantType
}

//
//  CKAsset.swift
//  WWDCScholars
//
//  Created by Matthijs Logemann on 18/04/2017.
//  Copyright © 2017 Andrew Walker. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

extension CKAsset {
    func image() -> UIImage? {
            if let data = try? Data.init(contentsOf: fileURL) {
                return UIImage(data: data)
            }
        return nil
    }
}

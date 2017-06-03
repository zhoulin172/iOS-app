//
//  ProfileSocialAccountsFactory.swift
//  WWDCScholars
//
//  Created by Andrew Walker on 06/05/2017.
//  Copyright © 2017 WWDCScholars. All rights reserved.
//

import Foundation
import UIKit

internal final class ProfileSocialAccountsFactory {
    
    // MARK: - Private Properties
    
    private let socialMedia: SocialMedia
    
    // MARK: - Lifecycle
    
    internal init(socialMedia: SocialMedia) {
        self.socialMedia = socialMedia
    }
    
    // MARK: - Internal Functions
    
    internal func accountButtons() -> [SocialAccountButton] {
        let buttons = [self.facebookButton(), self.twitterButton(), self.linkedInButton(), self.websiteButton(), self.gitHubButton(), self.iMessageButton()]
        let visibleButtons = buttons.flatMap({ ($0 as? SocialAccountButton) })
        
        return visibleButtons
    }
    
    // MARK: - Private Functions
    
    private func iMessageButton() -> UIButton? {
        if let iMessage = self.socialMedia.iMessage, !iMessage.isEmpty {
            return self.accountButton(withImageName: "iMessage", url: iMessage)
        }
        
        return nil
    }
    
    private func gitHubButton() -> UIButton? {
        if let gitHubURL = self.socialMedia.gitHub, !gitHubURL.isEmpty {
            return self.accountButton(withImageName: "gitHub", url: gitHubURL)
        }
        
        return nil
    }
    
    private func websiteButton() -> UIButton? {
        if let websiteURL = self.socialMedia.website, !websiteURL.isEmpty {
            return self.accountButton(withImageName: "website", url: websiteURL)
        }
        
        return nil
    }
    
    private func linkedInButton() -> UIButton? {
        if let linkedInURL = self.socialMedia.linkedIn, !linkedInURL.isEmpty {
            return self.accountButton(withImageName: "linkedIn", url: linkedInURL)
        }
        
        return nil
    }
    
    private func facebookButton() -> UIButton? {
        if let facebookURL = self.socialMedia.facebook, !facebookURL.isEmpty {
            return self.accountButton(withImageName: "facebook", url: facebookURL)
        }
        
        return nil
    }
    
    private func twitterButton() -> UIButton? {
        if let twitterURL = self.socialMedia.twitter, !twitterURL.isEmpty {
            return self.accountButton(withImageName: "twitter", url: twitterURL)
        }
        
        return nil
    }
    
    private func accountButton(withImageName name: String, url: String) -> SocialAccountButton {
        let button = SocialAccountButton()
        let image = UIImage(named: name)
        button.accountDetail = url
        button.setBackgroundImage(image, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        button.isUserInteractionEnabled = false
        return button
    }
}

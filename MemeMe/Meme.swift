//
//  Meme.swift
//  MemeMe
//
//  Created by Yang Ji on 5/20/16.
//  Copyright © 2016 Yang Ji. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String!
    var bottomText: String!
    var originImage: UIImage!
    var editImage: UIImage!
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.editImage = memedImage
        self.bottomText = bottomText
        self.topText = topText
        self.originImage = image
    }
}

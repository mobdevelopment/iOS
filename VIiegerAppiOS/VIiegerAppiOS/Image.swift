//
//  Image.swift
//  VIiegerAppiOS
//
//  Created by Michael Schouten on 06/06/16.
//  Copyright © 2016 Michael Schouten. All rights reserved.
//

import Foundation

class Image {
    
    var id: Int
    var path: String
    var correct: Bool
    
    init(_id: Int, _path: String, _correct: Bool){
        id = _id
        path = _path
        correct = _correct
    }
    
}
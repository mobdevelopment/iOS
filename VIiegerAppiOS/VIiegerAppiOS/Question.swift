//
//  Question.swift
//  VIiegerAppiOS
//
//  Created by Michael Schouten on 06/06/16.
//  Copyright © 2016 Michael Schouten. All rights reserved.
//

import Foundation

class Question: NSObject {
    
    var id: Int
    var name: String
    var altitude: Image
    var compass: Image
    var images: [Image]
    
    init(_id: Int, _altitude: Image, _compass: Image, _images: [Image]){
        id = _id
        name = "Question \(_id)"
        altitude = _altitude
        compass = _compass
        images = _images
    }
    
}

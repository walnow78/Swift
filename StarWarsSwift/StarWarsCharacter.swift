//
//  StarWarsCharacter.swift
//  StarWarsSwift
//
//  Created by Pawel Walicki on 9/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

import Foundation
import UIKit

class StarWarsCharacter {
 
    var name : NSString
    var alias : NSString
    var image : UIImage?
    var sound : NSString
    var url : NSURL?
    
    init(name : NSString, alias : NSString, image : UIImage?, sound : NSString, url : NSURL?){
        
        self.name = name
        self.alias = alias
        self.image = image
        self.sound = sound
        self.url = url
        
        return
    }
    
    init(name : NSString, image : UIImage?, sound : NSString, url : NSURL?){
        
        self.name = name
        self.alias = ""
        self.image = image
        self.sound = sound
        self.url = url
        
        return
    }

    

}

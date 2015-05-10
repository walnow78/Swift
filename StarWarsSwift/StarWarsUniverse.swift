//
//  StarWarsUniverse.swift
//  StarWarsSwift
//
//  Created by Pawel Walicki on 9/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

import Foundation


class StarWarsUniverse {
 
    // Creo dos arrays
    
    var rebels = [StarWarsCharacter]()
    var imperials = [StarWarsCharacter]()
    
    init() {}
    
    func rebelsCount()->Int{
        return rebels.count
    }
    
    func imperialCount()->Int{
        return imperials.count;
    }
    
    func addRebelCharacter(var rebel : StarWarsCharacter)->(){
        
        self.rebels.append(rebel)
        
    }
    
    func addImperialCharacter(var imperial : StarWarsCharacter)->(){
        
        self.imperials.append(imperial)
        
    }
    
    func rebelAtIndex(var index : Int)->StarWarsCharacter{
        
        return rebels[index]
        
    }
    
    func imperialAtIndex(var index : Int)->StarWarsCharacter{
        
        return imperials[index];
        
    }
    
    
}
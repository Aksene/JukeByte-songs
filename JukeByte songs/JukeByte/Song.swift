//
//  Song.swift
//  JukeByte
//
//  Created by Abdou K Sene on 4/15/19.
//  Copyright © 2019 Abdou K Sene. All rights reserved.
//

import Foundation

class Song{
    var id: Int
    var name: String
    var numLikes: Int
    var numPlays: Int
    
    init? (id: String, name: String, numLikes: String, numPlays: String){
        self.id = Int(id)!
        self.name = name
        self.numLikes = Int(numLikes)!
        self.numPlays = Int(numPlays)!
    }
   
    func getId() -> Int {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getNumLikes() -> Int {
        return numLikes
    }
    
    func getIdNumPlays() -> Int {
        return numPlays
    }
    
    func getCleanName(cleanName: String) -> String {

        //cleanName = (data as String).characters.split(separator: "." ).map(String.init)

        
        return cleanName
    }
}

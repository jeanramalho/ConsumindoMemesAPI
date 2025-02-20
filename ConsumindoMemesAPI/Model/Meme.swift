//
//  Meme.swift
//  ConsumindoMemesAPI
//
//  Created by Jean Ramalho on 19/02/25.
//
import Foundation

struct Meme: Codable {
    
    let success: Bool
    let data: Data
}

struct Data: Codable {
    let memes: [MemeObject]
}

struct MemeObject: Codable {
    let id, name: String
    let url: String
    let width, height, boxCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height
        case boxCount = "box_count"
    }
}

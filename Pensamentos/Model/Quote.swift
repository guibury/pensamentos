//
//  Quote.swift
//  Pensamentos
//
//  Created by Guilherme Bury on 11/02/2018.
//  Copyright © 2018 Guilherme Bury. All rights reserved.
//

import Foundation

struct Quote: Codable { //Encodable and Decodable
 
    let quote: String
    let author: String
    let image: String
    
    var quoteFormatted: String {
        return "〝" + quote + "〞"
    }
    
    var authorFormatted: String {
        return "- " + author + " -"
    }
}

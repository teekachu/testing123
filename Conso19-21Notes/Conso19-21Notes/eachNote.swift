//
//  eachNote.swift
//  Conso19-21Notes
//
//  Created by Ting Becker on 8/21/20.
//  Copyright © 2020 TeeksCode. All rights reserved.
//

import UIKit

class allNotes: NSObject, Codable{
    var notes: [eachNote]
    
    init(notes: [eachNote]) {
        self.notes = allNotes
    }
}


class eachNote: NSObject, Codable {
    var detail: String
    
    init(detail: String){
        self.detail = detail
    }
    
}

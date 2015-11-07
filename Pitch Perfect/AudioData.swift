//
//  AudioData.swift
//  Pitch Perfect
//
//  Created by Tanveer Bashir on 11/7/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import Foundation
class AudioData {
    var title:String
    var filePathURL:NSURL
    
    init(title:String, fileURL:NSURL){
        self.title = title
        self.filePathURL = fileURL
    }
}
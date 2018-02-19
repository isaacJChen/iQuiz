//
//  File.swift
//  iQuiz
//
//  Created by Isaac Chen on 2/18/18.
//  Copyright © 2018 Isaac Chen. All rights reserved.
//

import Foundation

func setUp() {
    let urlString = "http://tednewardsandbox.site44.com/questions.json"
    guard let url = URL(string: urlString) else {return}
    
    URLSession.shared.dataTask(with: url) { (data, response, err) in
        
        guard let data = data else {return}
        let dataString = String(data: data, encoding: .utf8)
        print("dataString")
        }.resume()
}







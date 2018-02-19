//
//  URLParsing.swift
//  iQuiz
//
//  Created by Isaac Chen on 2/18/18.
//  Copyright © 2018 Isaac Chen. All rights reserved.
//

import Foundation

struct Quiz: Decodable{
    let title: String
    let desc: String
    let questions: [Question]
    
    var dictionary: [String:Any] {
        return [
            "title": title,
            "desc": desc,
            "questions": questions
        ]
    }
    
    var getNSDict: NSDictionary {
        return dictionary as NSDictionary
    }
}

struct Question: Decodable{
    let text: String
    let answer: String
    let answers: [String]
    
    var dictionary: [String: Any] {
        return [
            "text": text,
            "answer": answer,
            "answers": answers
        ]
    }
    
    var getNSDict: NSDictionary {
        return dictionary as NSDictionary
    }
}

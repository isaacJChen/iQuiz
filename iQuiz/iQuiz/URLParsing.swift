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
}

struct Question: Decodable{
    let text: String
    let answer: String
    let answers: [String]
}

class EncoderForJSON{
    static func encodeQuestions(questions:[Question]) -> NSArray{
        var returnedArray:[NSDictionary] = []
        questions.forEach { (question) in
            var dict: [String:Any] = [:]
            dict["text"] = question.text
            dict["answer"] = question.answer
            dict["answers"] = question.answers
            returnedArray.append(dict as NSDictionary)
        }
        
        return returnedArray as NSArray
    }
    
    static func encodeQuizes(quizes:[Quiz]) -> NSArray{
        var returnedArray:[NSDictionary] = []
        quizes.forEach { (quiz) in
            var dict: [String:Any] = [:]
            dict["title"] = quiz.title
            dict["desc"] = quiz.desc
            dict["questions"] = encodeQuestions(questions: quiz.questions)
            returnedArray.append(dict as NSDictionary)
        }
        
        return returnedArray as NSArray
    }
    
    static func toJSONData(from array:NSArray) -> Data? {
        do {
            //Convert to Data
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions.prettyPrinted)
            return jsonData
            
        } catch {
            print("failed")
            return nil
        }
    }
    
}

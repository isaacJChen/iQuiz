//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Isaac Chen on 2/13/18.
//  Copyright © 2018 Isaac Chen. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var result:String = ""
    var numberOfCompleted = 0
    var numberOfQuestions = 0
    var numberOfCorrect = 0
    var isBacking = false

    @IBOutlet weak var label: UILabel!
    
    @IBAction func backPressed(_ sender: Any) {
        isBacking = true
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if numberOfCompleted == numberOfQuestions {
            performSegue(withIdentifier: "answerToFinish", sender: self)
        } else {
            performSegue(withIdentifier: "answerToQuestion", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = result
        label.numberOfLines = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        NSLog("the number of questions is \(numberOfQuestions)")
        NSLog("the number of completed is \(numberOfCompleted)")
        if !isBacking{
            if numberOfCompleted == numberOfQuestions {
                let finished = segue.destination as! FinishedViewController
                finished.numberOfQuestions = numberOfQuestions
                finished.numberOfCorrect = numberOfCorrect
            } else {
                let question = segue.destination as! QuestionViewController
                question.numberOfCompleted = numberOfCompleted
                question.numberOfQuestions = numberOfQuestions
                question.numberOfCorrect = numberOfCorrect
            }
        }
    }
    


}

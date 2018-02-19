//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Isaac Chen on 2/13/18.
//  Copyright © 2018 Isaac Chen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var correctAnswer: UIButton!
    @IBOutlet weak var wrongAnswer1: UIButton!
    @IBOutlet weak var wrongAnswer2: UIButton!
    @IBOutlet weak var wrongAnswer4: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet var swpie: UISwipeGestureRecognizer!
    
    var result = "incorrect"
    var isCorrect = false
    var numberOfQuestions = 0
    var numberOfCompleted = 0
    var numberOfCorrect = 0
    
    @IBOutlet weak var lebel: UILabel!
    var questions:[Question] = []
    
    var isBacking = false
    
    
    @IBAction func backIsPressed(_ sender: Any) {
        isBacking = true
    }
    
    @IBAction func firstAnswerPRessed(_ sender: Any) {
        correctAnswer.backgroundColor = UIColor.lightGray
        wrongAnswer1.backgroundColor = UIColor.cyan
        wrongAnswer2.backgroundColor = UIColor.cyan
        wrongAnswer4.backgroundColor = UIColor.cyan
        
        isCorrect = questions[numberOfCompleted].answer == "1"
        if isCorrect {
            self.result = "correct, YAY!!!!! the correct answer is: \(questions[numberOfCompleted].answers[Int(questions[numberOfCompleted].answer)!-1])"
        } else {
            self.result = "incorrect, the correct answer is: \(questions[numberOfCompleted].answers[Int(questions[numberOfCompleted].answer)!-1])"
        }
        
        submit.isEnabled = true
        swpie.isEnabled = true
    }
    
    @IBAction func secondAnswerPressed(_ sender: Any) {
        correctAnswer.backgroundColor = UIColor.cyan
        wrongAnswer1.backgroundColor = UIColor.lightGray
        wrongAnswer2.backgroundColor = UIColor.cyan
        wrongAnswer4.backgroundColor = UIColor.cyan
        isCorrect = questions[numberOfCompleted].answer == "2"
        if isCorrect {
            self.result = "correct, YAY!!!!! the correct answer is: \(questions[numberOfCompleted].answers[Int(questions[numberOfCompleted].answer)!-1])"
        } else {
            self.result = "incorrect, the correct answer is: \(questions[numberOfCompleted].answers[Int(questions[numberOfCompleted].answer)!-1])"
        }
        submit.isEnabled = true
        swpie.isEnabled = true
    }
    
    @IBAction func thirdAnswerPRessed(_ sender: Any) {
        correctAnswer.backgroundColor = UIColor.cyan
        wrongAnswer1.backgroundColor = UIColor.cyan
        wrongAnswer2.backgroundColor = UIColor.lightGray
        wrongAnswer4.backgroundColor = UIColor.cyan
        isCorrect = questions[numberOfCompleted].answer == "3"
        if isCorrect {
            self.result = "correct, YAY!!!!! the correct answer is: \(questions[numberOfCompleted].answers[Int(questions[numberOfCompleted].answer)!-1])"
        } else {
            self.result = "incorrect, the correct answer is: \(questions[numberOfCompleted].answers[Int(questions[numberOfCompleted].answer)!-1])"
        }
        submit.isEnabled = true
        swpie.isEnabled = true
    }
    
    @IBAction func fourthAnswerPressed(_ sender: Any) {
        correctAnswer.backgroundColor = UIColor.cyan
        wrongAnswer1.backgroundColor = UIColor.cyan
        wrongAnswer2.backgroundColor = UIColor.cyan
        wrongAnswer4.backgroundColor = UIColor.lightGray
        isCorrect = questions[numberOfCompleted].answer == "4"
        if isCorrect {
            self.result = "correct, YAY!!!!! the correct answer is: \(questions[numberOfCompleted].answers[Int(questions[numberOfCompleted].answer)!-1])"
        } else {
            self.result = "incorrect, the correct answer is: \(questions[numberOfCompleted].answers[Int(questions[numberOfCompleted].answer)!-1])"
        }
        submit.isEnabled = true
        swpie.isEnabled = true
    }
    
    @IBAction func sbumitPRessed(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        correctAnswer.backgroundColor = UIColor.cyan
        wrongAnswer1.backgroundColor = UIColor.cyan
        wrongAnswer2.backgroundColor = UIColor.cyan
        wrongAnswer4.backgroundColor = UIColor.cyan
        
        correctAnswer.setTitle(questions[numberOfCompleted].answers[0], for: .normal)
        wrongAnswer1.setTitle(questions[numberOfCompleted].answers[1], for: .normal)
        wrongAnswer2.setTitle(questions[numberOfCompleted].answers[2], for: .normal)
        wrongAnswer4.setTitle(questions[numberOfCompleted].answers[3], for: .normal)
        lebel.text = questions[numberOfCompleted].text
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
        if !isBacking {
            numberOfCompleted+=1
            let answer = segue.destination as! AnswerViewController
            NSLog("the number of questions is \(numberOfQuestions)")
            NSLog("the number of completed is \(numberOfCompleted)")
            answer.result = self.result
            answer.numberOfCompleted = numberOfCompleted
            answer.numberOfQuestions = numberOfQuestions
            answer.numberOfCorrect = isCorrect ? numberOfCorrect + 1 : numberOfCorrect
            answer.questions = questions
        }
    }

}

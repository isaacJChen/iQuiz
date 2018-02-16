//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Isaac Chen on 2/13/18.
//  Copyright © 2018 Isaac Chen. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var numberOfQuestions = 0
    var numberOfCorrect = 0

    override func viewDidLoad() {
        var percentage:Double
        super.viewDidLoad()
        if numberOfCorrect == 0 {
            percentage = 0.0
        } else {
            percentage = Double(round(Double(numberOfCorrect)/Double(numberOfQuestions)*10000)/100)
        }
        label.text = "You got \(percentage)% correct"

        // Do any additional setup after loading the view.
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

}

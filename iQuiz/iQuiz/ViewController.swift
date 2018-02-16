//
//  ViewController.swift
//  iQuiz
//
//  Created by Isaac Chen on 2/11/18.
//  Copyright © 2018 Isaac Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    var numberOfQuestions = 0
    var numberOfCompleted = 0
    var numberOfCorrect = 0
    
    
    fileprivate var questionView: QuestionViewController!
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = questions[indexPath.row]
        cell.detailTextLabel?.text = "This is description"
        cell.imageView?.image = UIImage(named: "placeHolder")
        tableView.tableFooterView = UIView()
        return cell
    }
    
    fileprivate func switchViewController(_ from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMove(toParentViewController: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, at: 0)
            to!.didMove(toParentViewController: self)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //toolbar block
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toolBar)
        
        
        toolBarConstraints = [
            toolBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ]
        
        NSLayoutConstraint.activate(toolBarConstraints)
        
        //settings block
        settings.action = #selector(settingsPressed(sender:))
        
        //table block
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        
        
        tableConstraints = [
            table.widthAnchor.constraint(equalTo: view.widthAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.topAnchor.constraint(equalTo: toolBar.bottomAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        table.dataSource = self
        table.delegate = self
        
        NSLayoutConstraint.activate(tableConstraints)
        
    }
    

    
    //toolBar stuff
    var toolBarConstraints:[NSLayoutConstraint] = []
    @IBOutlet weak var toolBar: UIToolbar!
    
    //table stuff
    var tableConstraints:[NSLayoutConstraint] = []
    var questions = ["Mathematics", "Marvel Super Heroes", "Science"]
    @IBOutlet weak var table: UITableView!
    
    //settings stuff
    @IBOutlet weak var settings: UIBarButtonItem!
    
    @objc func settingsPressed(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings go here", message: "This is an alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        numberOfQuestions = 3
        let question = segue.destination as! QuestionViewController
        NSLog("the number of questions is \(numberOfQuestions)")
        NSLog("the number of completed is \(numberOfCompleted)")
        question.numberOfQuestions = numberOfQuestions
        question.numberOfCompleted = numberOfCompleted
        question.numberOfCorrect = numberOfCorrect
    }


}


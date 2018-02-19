//
//  ViewController.swift
//  iQuiz
//
//  Created by Isaac Chen on 2/11/18.
//  Copyright © 2018 Isaac Chen. All rights reserved.
//

import UIKit


class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    var quizType = 0
    
    var numberOfQuestions = 0
    var numberOfCompleted = 0
    var numberOfCorrect = 0
    
    var quizes: [Quiz] = []
    
    
    fileprivate var questionView: QuestionViewController!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = self.quizes[indexPath.row].title
        cell.detailTextLabel?.text = self.quizes[indexPath.row].desc
        cell.imageView?.image = (UIImage(named: self.quizes[indexPath.row].title) != nil) ? UIImage(named: self.quizes[indexPath.row].title) : UIImage(named: "placeHolder")
        tableView.tableFooterView = UIView()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        quizType = indexPath.row
        performSegue(withIdentifier: "mainToQuestion", sender: self)
        print("pressed")
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
        
        
        if Reachability.isConnectedToNetwork() {
            
            //url block
            guard let url = URL(string: "http://tednewardsandbox.site44.com/questions.json") else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {return}
                do{
                    let temp = try JSONDecoder().decode([Quiz].self, from: data)
                    self.quizes = temp
                } catch let jsonErr{
                    print("error for json parsing", jsonErr)
                }
                
                DispatchQueue.main.async{
                    self.table.reloadData()
                }
                
                let test = ["a","b"]
                
                if (test as NSArray).write(toFile: NSHomeDirectory() + "/Documents/data", atomically: true) {
                    print("did it")
                } else {
                    print("failed to write")
                }
                
                }.resume()
        } else {
            
            let alert = UIAlertController(title: "No Internet Connection!", message: "Will now use local data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    

    
    //toolBar stuff
    var toolBarConstraints:[NSLayoutConstraint] = []
    @IBOutlet weak var toolBar: UIToolbar!
    
    //table stuff
    var tableConstraints:[NSLayoutConstraint] = []
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
        let question = segue.destination as! QuestionViewController
        question.numberOfQuestions = quizes[quizType].questions.count
        question.numberOfCompleted = numberOfCompleted
        question.numberOfCorrect = numberOfCorrect
        question.questions = quizes[quizType].questions
    }


}


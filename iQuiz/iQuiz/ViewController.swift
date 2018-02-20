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
    
    var connectionStatus = true
    
    let defaultURL = UserDefaults.standard.string(forKey: "urltouse") == nil ? "http://tednewardsandbox.site44.com/questions.json" : UserDefaults.standard.string(forKey: "urltouse")!
    
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
            guard let url = URL(string: defaultURL) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if data == nil {
                    print("fail here!")
                } else {
                    guard let data = data else {return}
                    do{
                        let temp = try JSONDecoder().decode([Quiz].self, from: data)
                        print(temp)
                        self.quizes = temp
                        
                        
                        DispatchQueue.main.async{
                            self.table.reloadData()
                        }
                        
                        let writable = EncoderForJSON.encodeQuizes(quizes: self.quizes)
                        
                        if (writable as NSArray).write(toFile: NSHomeDirectory() + "/Documents/data", atomically: true) {
                            //let testArr = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/data")
                        } else {
                            print("failed to write")
                        }
                    } catch let jsonErr{
                        print("error for json parsing", jsonErr)
                    }
                }
                
                
            }.resume()
        } else {
            connectionStatus = false
            
            //let localData = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/data")
            
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let localData = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/data")
        
        if !connectionStatus {
            //let localData = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/data")
            //print(EncoderForJSON.toJSON(from:localData!))
            //print("no internet")
            
            if localData == nil{
                let alert = UIAlertController(title: "No Internet Connection!", message: "Connection is required for first launch of the app", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                
                let data = EncoderForJSON.toJSONData(from: localData!)
                
                do{
                    let temp = try JSONDecoder().decode([Quiz].self, from: data!)
                    self.quizes = temp
                    self.table.reloadData()
                } catch let jsonErr{
                    print("error for json parsing", jsonErr)
                }
                
                let alert = UIAlertController(title: "No Internet Connection!", message: "Now using local storage", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
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
        let alert = UIAlertController(title: "Settings", message:"", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Check Now", comment: "Default action"), style: .`default`, handler: { _ in
            
            
            if alert.textFields![0].text! == "" {
                print("empty case caught!")
            } else {
                let output = UserDefaults.standard.string(forKey: "urltouse") == nil ? "http://tednewardsandbox.site44.com/questions.json" : UserDefaults.standard.string(forKey: "urltouse")
                UserDefaults.standard.set(alert.textFields![0].text!, forKey: "urltouse")
                
                guard let url = URL(string: UserDefaults.standard.string(forKey: "urltouse") == nil ? "http://tednewardsandbox.site44.com/questions.json" : UserDefaults.standard.string(forKey: "urltouse")!) else {return}
                
                URLSession.shared.dataTask(with: url) { (data, response, err) in
                    if data == nil {
                        UserDefaults.standard.set(output, forKey: "urltouse")
                        
                        
                        let alert = UIAlertController(title: "Warning!", message: "The url you entered was not valid, we are still using the previous one.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                        
                    } else {
                        guard let data = data else {return}
                        do{
                            let temp = try JSONDecoder().decode([Quiz].self, from: data)
                            self.quizes = temp
                            
                            
                            DispatchQueue.main.async{
                                self.table.reloadData()
                            }
                            
                            let writable = EncoderForJSON.encodeQuizes(quizes: self.quizes)
                            
                            if (writable as NSArray).write(toFile: NSHomeDirectory() + "/Documents/data", atomically: true) {
                                //let testArr = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/data")
                            } else {
                                print("failed to write")
                            }
                        } catch let jsonErr{
                            UserDefaults.standard.set(output, forKey: "urltouse")
                            
                            let alert = UIAlertController(title: "Warning!", message: "The url you entered was not valid, we are still using the previous one.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                                NSLog("The \"OK\" alert occured.")
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    
                    }.resume()
                
                //self.url = alert.textFields![0].text!
                //print(self.url)
            }
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("canceled")
        }))
        alert.addTextField { (textField : UITextField!) in
            textField.placeholder = "Enter url"
        }
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


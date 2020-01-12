//
//  ViewController.swift
//  ExcelTest
//
//  Created by Jamshed Alam on 10/23/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var taskArr = [Task]()
    var task: Task!
    var urlFile : String = ""
    
    @IBOutlet weak var filePathLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Prepare data for excel sheet
        for i in 0..<5 {
            task = Task()
            task.name = "Jamshed, \(i+1)"
            task.date = "\(Date())"
            task.startTime = "Start \(Date())"
            task.endTime = "End \(Date())"
            taskArr.append(task!)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    // MARK: CSV file creating
    func creatCSV(_ fileType : Int) -> Void {
        
        let fileName = fileType == 1 ? "Data.xls" : "Data.csv" 
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "Date,Task Name,Time Started,Time Ended\n"
        
        for task in taskArr {
            let newLine = "\(task.date),\(task.name),\(task.startTime),\(task.endTime)\n"
            csvText.append(newLine)
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            
            
            let url = path
            self.filePathLabel.text = url?.absoluteString
            
            let activityViewController = UIActivityViewController(activityItems: [url as Any] , applicationActivities: nil)
            
            DispatchQueue.main.async {
                self.present(activityViewController, animated: true, completion: nil)
            }
                            
        } catch {
            print("Failed to create file ")
            print("\(error)")
        }
        print(path ?? "not found")
    }
    
    // MARK: User Action
    @IBAction func createButtonClicked(_ sender : UIButton) {
        self.creatCSV(sender.tag)
    }
    
}



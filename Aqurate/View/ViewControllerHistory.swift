//
//  ViewControllerTips.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 03/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerHistory: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var trainingData : [Training] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()

        tableView.reloadData()
        //self.navigationController?.navigationBar.tintColor = UIColor.white
       // self.navigationController?.navigationBar.backgroundColor = Colors.orange
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        tableView.reloadData()
        viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func loadItems(){
        let request : NSFetchRequest<Training> = Training.fetchRequest()

        do {
            trainingData = try context.fetch(request)
            tableView.reloadData()

        } catch  {
            print("error")
        }
        
        tableView.reloadData()

    }
    

}

extension ViewControllerHistory : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return trainingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as! TableViewCellHistory
        
        cell.lblDate.text = "\(trainingData[indexPath.row].date ?? "no data")"
        
        cell.lblMode.text = "\(trainingData[indexPath.row].mode ?? "No Mode") - \(trainingData[indexPath.row].difficulty ?? "No Difficulty")"
        
        cell.lblRating.text = "\(trainingData[indexPath.row].rating ?? "No Rating")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "Statistics")
        self.navigationController?.pushViewController(viewController!, animated: true)
        
        let tempScores = trainingData[indexPath.row].scores?.array as! [Score]
        let tempDiff = trainingData[indexPath.row].difficulty
        if tempDiff == "Semi-Pro" {
            HighTotalScore = 30
        } else {
            HighTotalScore = 40
        }
        detailedScore = []
        print(trainingData.count)
        for tempScore in tempScores {
            print(tempScore.score)
            detailedScore.append(Int(tempScore.score))
        }
        gameScore = 0
        for detail in detailedScore {
            gameScore += detail
        }
    }
    


}

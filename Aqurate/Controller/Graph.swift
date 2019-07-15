//
//  graph.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 15/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit

class Graph: UIView {
    
    var lineGraph = UIBezierPath()
    var barLineX = UIBezierPath()
    var barLineY = UIBezierPath()
    
    let HighTotalScore = 30
    
    func scoreText(x:Int){
        let score = x
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 50, width: 400, height: 120)
        label.font = label.font.withSize(100)
        label.font = UIFont.boldSystemFont(ofSize: 100)
        label.textAlignment = .center
        let rating = score * 100 / HighTotalScore
        if (rating >= 80){
            label.text = "A"
        }else if(rating >= 60){
            label.text = "B"
        }else if(rating >= 40){
            label.text = "C"
        }else if(rating >= 20){
            label.text = "D"
        }else{
            label.text = "E"
        }
        self.addSubview(label)
    }
    
    func statistik(x:Int){
        let label = UILabel()
        let label2 = UILabel()
        label.frame = CGRect(x: 55, y: 500, width: 400, height: 120)
        label2.frame = CGRect(x: 55, y: 540, width: 400, height: 120)
        label.font = label.font.withSize(30)
        label2.font = label.font.withSize(30)
        label.text = "Point Earn: \(x)/\(HighTotalScore)"
        let y = Int(x * 100 / HighTotalScore)
        label2.text = "Accuracy : \(y)%"
        self.addSubview(label)
        self.addSubview(label2)
    }
    
    func generateLabelY(x:Int, y:Int, z: Int){
        let label = UILabel()
        label.text = String(z)
        label.frame = CGRect(x: x, y: y, width: 10, height: 15)
        self.addSubview(label)
    }
    
    
    func generateLabelX1(x:Int, y:Int, z: Int, width: Int = 10){
        let label = UILabel()
        label.text = String(z)
        label.frame = CGRect(x: x, y: y, width: width, height: 15)
        self.addSubview(label)
    }
    
    func xLine(){
        barLineX.move(to: .init(x: 50, y: 450))
        barLineX.addLine(to: .init(x: 50, y: 230))
        UIColor.red.setStroke()
        barLineX.lineWidth = 3
        barLineX.stroke()
    }
    
    func yLine(){
        barLineY.move(to: .init(x: 50, y: 450))
        barLineY.addLine(to: .init(x: 370, y: 450))
        UIColor.red.setStroke()
        barLineY.lineWidth = 3
        barLineY.stroke()
    }
    
    func createLine(x: Int, y: Int){
        let newLine = UIBezierPath()
        newLine.move(to: .init(x: x, y: y))
        newLine.addLine(to: .init(x: x + 300, y: y))
        UIColor.gray.setStroke()
        newLine.lineWidth = 1
        newLine.stroke()
    }
    
    func boxX(x: Int, y: Int){
        let box = UIBezierPath()
        box.move(to: .init(x: x, y:y))
        box.addLine(to: .init(x: x+3, y: y))
        box.lineWidth = 4
        box.stroke()
    }
    func boxY(x: Int, y: Int){
        let box = UIBezierPath()
        box.move(to: .init(x: x, y:y))
        box.addLine(to: .init(x: x, y: y+3))
        box.lineWidth = 4
        box.stroke()
    }
    
    func graph(score: [Int]){
        //y kecil = 460, y gede = 300 dikurang 40
        lineGraph.move(to: .init(x: 80, y: 450 - 40 * score[0]))
        for i in 1...score.count - 1 {
            lineGraph.addLine(to: .init(x: 80 + 30*i, y: 450 - 40 * score[i]))
        }
        
        UIColor.black.setStroke()
        lineGraph.lineWidth = 2
        
        lineGraph.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        
        for i in 0...4 {
            createLine(x: 50, y: 410-(40*i))
        }
        
        for i in 0...4 {
            boxX(x: 25, y: 410-(40*i))
        }
        
        for i in 0...9 {
            boxY(x: 80+(30*i), y: 490)
        }
        
        xLine()
        yLine()
        graph(score: detailedScore)
        
        for a in 0...4 {
            generateLabelY(x: 30, y: 400-(40*a), z: 1+a)
        }
        
        for b in 0...9{
            if b == 9 {
                generateLabelX1(x: 75+(30*b), y: 470, z: 1+b, width: 20)
            } else {
                generateLabelX1(x: 75+(30*b), y: 470, z: 1+b)
            }
        }
        
        let totalScore = UserDefaults.standard.object(forKey: "savedScore")
        scoreText(x: totalScore as! Int)
        statistik(x: totalScore as! Int)
    }
}

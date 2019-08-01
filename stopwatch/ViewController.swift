//
//  ViewController.swift
//  stopwatch
//
//  Created by apple on 01/08/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var timer = Timer()
    var minutes : Int = 0
    var seconds : Int = 0
    var fractions :Int  = 0
    var startStopWatch : Bool = true
    var addLap : Bool = false
    var stopWatchString : String = ""
    var laps : [String] = []
    
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetbtn: UIButton!
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.timerText.text = "00:00:00"
    }

    @IBAction func resetTimerButton(_ sender: Any) {
        if addLap == true{
            laps.insert(stopWatchString, at: 0)
            lapsTableView.reloadData()
        }else{
            addLap = false
            fractions = 0
            minutes = 0
            seconds = 0
            stopWatchString = "00:00:00"
            self.timerText.text = stopWatchString
            laps = []
            lapsTableView.reloadData()
        }
    }
    
    @IBAction func startTimerButton(_ sender: Any) {
    
        if startStopWatch {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateStopwatch), userInfo: nil, repeats: true)
            startStopWatch = false
            
            self.startButton?.setTitle("Pause", for: .normal)
            self.resetbtn?.setTitle("Lap", for: .normal)
            
            addLap = true
            
        }else{
            timer.invalidate()
            startStopWatch = true
            addLap = false
        
            self.startButton?.setTitle("Start", for: .normal)
            self.resetbtn?.setTitle("Reset", for: .normal)
            
        }
    
    }
    
    @objc func updateStopwatch(){
        fractions += 1
        
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"

        stopWatchString = "\(minutesString):\(secondString):\(fractionString)"
        self.timerText.text = stopWatchString
        
    }
    
    //Methods for table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timerTable", for: indexPath)
        
        cell.textLabel?.text = "Lap \(laps.count-indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]

        return cell
    }
    
    
    
}


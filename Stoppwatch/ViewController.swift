//
//  ViewController.swift
//  Stoppwatch
//
//  Created by Marco F.A. Corzani on 22.12.14.
//  Copyright (c) 2014 Alphaweb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Instance variables
    var timer: NSTimer?
    var startTime: NSDate?
    var currentTime: NSDate?
    var stopTime: NSDate?
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
   
    @IBOutlet weak var zwischenZeit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Method Stubs
    
    func start() {
        
        
        if timer == nil {   // Start a timer
          timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTimer:"), userInfo: nil, repeats: true)  // : ist wichtig!
        
            
            
            
            if stopTime != nil {   //calculate the duration elapsed from start to stop, subtract from new start time
            
            var duration = stopTime?.timeIntervalSinceDate(startTime!)
            startTime = NSDate(timeInterval: -duration!, sinceDate: NSDate())
                
            

            
            } else {
               startTime = NSDate()  //pick new start time
                
            }
        
            
        } else {
            // Dont start a new timer!
            }
        
    }
    
    func updateTimer(myTimer: NSTimer) {
        
        currentTime = NSDate()
        if startTime != nil {
            var duration = currentTime?.timeIntervalSinceDate(startTime!)
            //println(duration)
            //timeLabel.text = duration?.description
        
            
            timeLabel.text = dateStringFromTimeInterval(duration!)
            
        }
        
    }
    
    func dateStringFromTimeInterval(timeInterval: NSTimeInterval) -> String {
    
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SS"
        dateFormatter.timeZone = NSTimeZone(name: "GMT")
        
        var date = NSDate(timeIntervalSince1970: timeInterval)
    
        return dateFormatter.stringFromDate(date)
    
    
    }
    
    func stop()  {
        stopTime = NSDate()
        
        var duration = stopTime?.timeIntervalSinceDate(startTime!)
        startTime = NSDate(timeInterval: -duration!, sinceDate: NSDate())
        
        zwischenZeit.text = dateStringFromTimeInterval(duration!)
        
        // Stop the timer
        
        timer?.invalidate()
        timer = nil
        
        
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        
        startTime = nil
        stopTime = nil
        currentTime = nil
        timeLabel.text = dateStringFromTimeInterval(0)
        zwischenZeit.text = dateStringFromTimeInterval(0)
        
    }
    

    @IBAction func startButtonPressed(sender: AnyObject) {
        start()
    }

    @IBAction func stopButtonPressed(sender: AnyObject) {
        stop()
    
    
    }

    @IBAction func resetButtonPressed(sender: AnyObject) {
        reset()
    }
}


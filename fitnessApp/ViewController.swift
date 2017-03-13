//
//  ViewController.swift
//  fitnessApp
//
//  Created by Pavani Baradi on 11/26/16.
//  Copyright © 2016 Pavani Baradi. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var pedometer: CMPedometer!

    @IBOutlet weak var steps: UILabel!
    @IBOutlet weak var floorsAscended: UILabel!
    @IBOutlet weak var floorsDescend: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pedometer = CMPedometer()
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startWorkout(_ sender: Any) {
        print("start workout")
        if CMPedometer.isStepCountingAvailable() && CMPedometer.isFloorCountingAvailable(){
            print("steps available")
            let fromDate = Date(timeIntervalSinceNow: -1 * 60)
            self.pedometer.startUpdates(from: fromDate, withHandler: { (data, error) in
                DispatchQueue.main.async(execute: {
                    if error == nil {
                        print(data!.numberOfSteps)
                        self.steps.text = "\(data!.numberOfSteps)"
                        self.floorsAscended.text = "\(data!.floorsAscended!)"
                        self.floorsDescend.text = "\(data!.floorsDescended!)"
                        self.distance.text = "\(roundf(Float((data!.distance)!)))"
                    }
                    
                })
            })
        }

    }
    @IBAction func stopWorkout(_ sender: Any) {
        print("stop workout")
        self.pedometer.stopUpdates()
    }

}


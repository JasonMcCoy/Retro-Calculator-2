//
//  ViewController.swift
//  retroCalc2
//
//  Created by Jason McCoy on 5/14/16.
//  Copyright © 2016 Jason McCoy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Clear = ""
        case Divide = "/"
        case Multiply = "x"
        case Subtract = "-"
        case Add = "+"
        case Empty = "blank"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty
    
    var btnSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("buttonPush1", ofType: "mp3")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer (contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    @IBAction func numberPressed(buttonPush1: UIButton!) {
        playSound()
        runningNumber += "\(buttonPush1.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        processOperation(Operation.Clear)
    }
    
    @IBAction func divideButtonPressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func multiplyButtonPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func subtractButtonPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func equalButtonPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()

    
    if currentOperation != Operation.Empty {
        
        if runningNumber != "" {
            rightValStr = runningNumber
            runningNumber = ""
    
        if currentOperation == Operation.Multiply {
    
    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
    
    } else if currentOperation == Operation.Divide {
    
    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
    
    } else if currentOperation == Operation.Subtract {
    
    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
    
    } else if currentOperation == Operation.Add {
    
    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
    
    }
    
            leftValStr = result
            outputLabel.text = result

        }
    
            currentOperation = op
    
        } else {
    
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
    }
}

    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }

}
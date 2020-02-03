//
//  ViewController.swift
//  Assignment-3
//
//  Created by Dhruvil on 10/17/19.
//  Copyright © 2019 Dhruvil. All rights reserved.
//
struct Mode
{
    static var counter = 0
}

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var black: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var drawingModeOutlet: UIButton!
    @IBOutlet weak var deleteModeOutlet: UIButton!
    @IBOutlet weak var movingModeOutlet: UIButton!
    
    @IBOutlet weak var drawView: Drawing!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        red.isHidden = true
        blue.isHidden = true
        green.isHidden = true
        black.isHidden = true
    }
   
    @IBAction func drawingMode(_ sender: Any)
    {
        red.isHidden = false
        blue.isHidden = false
        green.isHidden = false
        black.isHidden = false
        Mode.counter = 1
        if drawView.time != nil
        {
            drawView.time.invalidate()
            drawView.time = nil
        }
        drawingModeOutlet.backgroundColor = UIColor.lightGray
        deleteModeOutlet.backgroundColor = UIColor.white
        movingModeOutlet.backgroundColor = UIColor.white
    }
    

    @IBAction func deleteMode(_ sender: Any)
    {
        red.isHidden = true
        blue.isHidden = true
        green.isHidden = true
        black.isHidden = true
        Mode.counter = 2
        if drawView.time != nil
        {
            drawView.time.invalidate()
            drawView.time = nil
        }
        drawingModeOutlet.backgroundColor = UIColor.white
        deleteModeOutlet.backgroundColor = UIColor.lightGray
        movingModeOutlet.backgroundColor = UIColor.white
    }
    
    @IBAction func movingMode(_ sender: Any)
    {
        red.isHidden = true
        blue.isHidden = true
        green.isHidden = true
        black.isHidden = true
        Mode.counter = 3
        drawingModeOutlet.backgroundColor = UIColor.white
        deleteModeOutlet.backgroundColor = UIColor.white
        movingModeOutlet.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func redButton(_ sender: Any)
    {
        drawView.strokeColor = UIColor.red.cgColor
        blue.backgroundColor = UIColor.init(red: 0, green: 0, blue: 1, alpha: 0.2)
        green.backgroundColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.2)
        black.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        red.backgroundColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func blueButton(_ sender: Any)
    {
        drawView.strokeColor = UIColor.blue.cgColor
        red.backgroundColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.2)
        green.backgroundColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.2)
        black.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        blue.backgroundColor = UIColor.init(red: 0, green: 0, blue: 1, alpha: 1)
    }
    
    @IBAction func greenButton(_ sender: Any)
    {
        drawView.strokeColor = UIColor.green.cgColor
        blue.backgroundColor = UIColor.init(red: 0, green: 0, blue: 1, alpha: 0.2)
        red.backgroundColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.2)
        black.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        green.backgroundColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 1)
    }
    
    @IBAction func blackButton(_ sender: Any)
    {
        drawView.strokeColor = UIColor.black.cgColor
        blue.backgroundColor = UIColor.init(red: 0, green: 0, blue: 1, alpha: 0.2)
        green.backgroundColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.2)
        red.backgroundColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.2)
        black.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
}


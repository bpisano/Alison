//
//  ViewController.swift
//  Alison
//
//  Created by bpisano on 05/30/2019.
//  Copyright (c) 2019 bpisano. All rights reserved.
//

import UIKit
import Alison

class ViewController: UIViewController {

    @IBOutlet weak var alisonView: ALView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        alisonView.setThinkingState()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        alisonView.setNormalState()
    }
    
}


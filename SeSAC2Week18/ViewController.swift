//
//  ViewController.swift
//  SeSAC2Week18
//
//  Created by 권민서 on 2022/11/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        APIService().profile()
        
    }


}


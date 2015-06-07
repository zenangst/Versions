//
//  ViewController.swift
//  VersionsDemo
//
//  Created by Christoffer Winterkvist on 20/05/15.
//
//

import UIKit
import Version

class ViewController: UIViewController {

    @IBOutlet weak var version: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        version.text = App.version
    }

}


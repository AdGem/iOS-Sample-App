//
//  ViewController.swift
//  AdGemTester
//
//  Created by Matthew Knippen on 4/11/18.
//  Copyright © 2018 AdGem. All rights reserved.
//

import UIKit
import AdGemSdk

class ViewController: UIViewController {

    @IBOutlet weak var standardVideoButton: UIButton!
    @IBOutlet weak var rewardedVideoButton: UIButton!

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.versionLabel.text = "iOS - V\(AdGem.sdkVersion)"

        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videosReady), name: videosReadyNotification, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let coins = UserDefaults.standard.integer(forKey: "coins")
        self.rewardLabel.text = "\(coins) coins"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showOfferwallTapped(_ sender: Any) {
        AdGem.showOfferWall()
    }

    @IBAction func showStandardVideoTapped(_ sender: Any) {
        AdGem.showVideoAd()
    }

    @IBAction func showRewardedVideoTapped(_ sender: Any) {
        AdGem.showRewardedVideoAd()
    }

    @objc func videosReady() {
        DispatchQueue.main.async {
            self.standardVideoButton.isHidden = false
            self.rewardedVideoButton.isHidden = false
        }
    }
}


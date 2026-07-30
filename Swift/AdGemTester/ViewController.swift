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

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.versionLabel.text = "iOS - V\(AdGem.sdkVersion)"

        // Refresh the balance whenever a reward is granted, even while this
        // screen is already visible (the reward callback can land after
        // viewDidAppear has already run).
        NotificationCenter.default.addObserver(
            forName: .adGemCoinsUpdated,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.refreshRewardLabel()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshRewardLabel()
    }

    private func refreshRewardLabel() {
        let coins = UserDefaults.standard.integer(forKey: "coins")
        self.rewardLabel.text = "\(coins) coins"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showOfferwallTapped(_ sender: Any) {
        AdGem.showOfferwall()
    }
}


//
//  SettingsViewController.swift
//  Pensamentos
//
//  Created by Guilherme Bury on 11/02/2018.
//  Copyright © 2018 Guilherme Bury. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {

    @IBOutlet weak var switchAutoRefresh: UISwitch!
    @IBOutlet weak var labelTimeInterval: UILabel!
    @IBOutlet weak var sliderTimeInterval: UISlider!
    @IBOutlet weak var segmentedControlColorScheme: UISegmentedControl!
    
    let config = Configuration.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }

    func formatView() {
        switchAutoRefresh.setOn(config.autoRefresh, animated: true)
        sliderTimeInterval.setValue(Float(config.timeInterval), animated: false)
        
        segmentedControlColorScheme.selectedSegmentIndex = config.colorScheme
        changeTimeIntervalLabel(with: config.timeInterval)
    }
    
    func changeTimeIntervalLabel(with value: Double) {
        labelTimeInterval.text = "Mudar após \(Int(value)) segundos"
    }
    
    @IBAction func changeAutoRefresh(_ sender: UISwitch) {
        config.autoRefresh = sender.isOn
    }
    @IBAction func changeTimeInterval(_ sender: UISlider) {
        let value = Double(round(sender.value))
        changeTimeIntervalLabel(with: value)
        config.timeInterval = value
    }
    @IBAction func changeColorScheme(_ sender: UISegmentedControl) {
        config.colorScheme = sender.selectedSegmentIndex
    }
}

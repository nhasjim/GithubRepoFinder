//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Nick Hasjim on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var minStarSlider: UISlider!
    var settings = GithubRepoSearchSettings()
    
    @IBOutlet weak var starsLabel: UILabel!
    
    weak var settingsDelegate: SettingsPresentingViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        starsLabel.text = "\(Int(minStarSlider.value))"
        // Do any additional setup after loading the view.
    }

    @IBAction func starsChange(_ sender: Any) {
        settings.minStars = Int(minStarSlider.value)
        starsLabel.text = "\(Int(minStarSlider.value))"
    }
    
    @IBAction func onSave(_ sender: Any) {
        //print((settings.minStars))
        settings.minStars = 100000
        self.settingsDelegate?.didSaveSettings(settings: settings)
        print("hello")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.settingsDelegate?.didCancelSettings()
        self.dismiss(animated: true, completion: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



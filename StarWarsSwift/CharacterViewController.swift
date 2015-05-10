//
//  CharacterViewController.swift
//  StarWarsSwift
//
//  Created by Pawel Walicki on 9/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

import UIKit
import AVFoundation

class CharacterViewController: UIViewController, UniverseViewControllerDelegate, UISplitViewControllerDelegate {

    var model : StarWarsCharacter
    
    var player = AVAudioPlayer()
    
    @IBOutlet weak var photoView: UIImageView!
    
    init(model : StarWarsCharacter){
        
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = model.name as String
    
    }

    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("CharacterViewController", owner: self, options: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    @IBAction func soundButton(sender: AnyObject) {

        var error:NSError?

        let path = NSBundle.mainBundle().pathForAuxiliaryExecutable(self.model.sound as String)
        
        let fileURL = NSURL(fileURLWithPath: path!)
        
        player = AVAudioPlayer(contentsOfURL: fileURL, error: &error)
        
        player.prepareToPlay()
        player.play()
    }
    
    
    @IBAction func wikiButton(sender: AnyObject) {
        
        var wikiVC : WikiViewController = WikiViewController(model: self.model)
        
        self.navigationController?.pushViewController(wikiVC, animated: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tableSelectChange:", name: "didSelectChange", object: nil)
        
        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        
        syncViewMode()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableSelectChange(notification: NSNotification) {
        
        let userInfo:Dictionary<String,StarWarsCharacter!> = notification.userInfo as! Dictionary<String,StarWarsCharacter!>
        
        self.model = userInfo["character"]!
        
        syncViewMode()
    
    }
    
    func syncViewMode()->(){
        
        self.title = self.model.name as String
        
        if let img = self.model.image{
            photoView.image = img
        }
        
    }
    
    func didselectChange(universeVC: UniverseViewController, character: StarWarsCharacter) {
        
        self.model = character
        
        println("delegado")
        
        self.syncViewMode()
    }
    
    func splitViewController(svc: UISplitViewController, willChangeToDisplayMode displayMode: UISplitViewControllerDisplayMode) {
        
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem()
    }
 
}

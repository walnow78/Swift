//
//  UniverseViewController.swift
//  StarWarsSwift
//
//  Created by Pawel Walicki on 9/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

import UIKit

// Creación del protocolo para el delegado

protocol UniverseViewControllerDelegate {
    func didselectChange(universeVC: UniverseViewController, character : StarWarsCharacter)
}

class UniverseViewController: UITableViewController, UniverseViewControllerDelegate{
    
    // Declaración del delegado
    
    var delegate : UniverseViewControllerDelegate?

    // Declaración del modelo
    
    var model : StarWarsUniverse

    // Inicializador
    
    init(model : StarWarsUniverse) {
       
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder!) {
        fatalError("NSCoding not supported")
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "UniverseTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableView.registerNib(UINib(nibName: "UniverseTableViewHeader", bundle: nil), forCellReuseIdentifier: "CustomHeader")

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Universe"
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int)-> String {
        
        if section == 1{
            return "Rebels"
        }else{
            return "Imperials"
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1{
            return self.model.rebelsCount()
        }else{
            return self.model.imperialCount()
        }
        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = tableView.dequeueReusableCellWithIdentifier("CustomHeader") as! UniverseTableViewHeader
        
        if section == 1{
            header.textHeaderView.text = "Rebels"
        }else{
            header.textHeaderView.text = "Imperials"
        }
        
        return header
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

//        let cellId = "cellId"
//        
//        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? UITableViewCell
//
//        if cell == nil {
//            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellId)
//        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! UniverseTableViewCell
        
        var character = currentCharacter(indexPath)
        
        cell.nameView.text = character.name as String
        cell.aliasView.text = character.alias as String
        
        if let img = character.image{
            cell.photoView.layer.cornerRadius = cell.photoView.frame.size.width / 2;
            cell.photoView.clipsToBounds = true;
            cell.photoView.image = img;
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var character = currentCharacter(indexPath)
        
        let notification : NSNotificationCenter = NSNotificationCenter.defaultCenter()
        
        var param = Dictionary<String, StarWarsCharacter>()
        
        param = ["character" : character]
        
        var chara : StarWarsCharacter = param["character"]!

        self.delegate?.didselectChange(self, character: character)
        
        notification.postNotificationName("didSelectChange", object: self, userInfo: param)
            
    }
    
    func currentCharacter(indexpath : NSIndexPath)->StarWarsCharacter{
        
        var character : StarWarsCharacter
        
        if indexpath.section == 1{
            
            character = self.model.rebelAtIndex(indexpath.row)
            
        }else{
            
            character = self.model.imperialAtIndex(indexpath.row)
        }
        
        return character
    }
    
    func didselectChange(universeVC: UniverseViewController, character: StarWarsCharacter) {
        
        var characterVC : CharacterViewController = CharacterViewController(model: character)
        
        self.navigationController?.pushViewController(characterVC, animated: true)
        
        
    }
}

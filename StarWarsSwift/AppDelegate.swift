//
//  AppDelegate.swift
//  StarWarsSwift
//
//  Created by Pawel Walicki on 9/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        // Creación de los personajes
        
        var c3po = StarWarsCharacter(name: "c3po", alias: "c3po", image: UIImage(named: "c3po.jpg"), sound: "c3po.caf", url: NSURL(string:"http://es.wikipedia.org/wiki/C-3PO"))
        var chewbacca = StarWarsCharacter(name: "Chewbacca", alias: "Chewbacca", image: UIImage(named:"chewbacca.jpg"), sound: "chewbacca.caf", url: NSURL(string: "http://es.wikipedia.org/wiki/Chewbacca"))
        var darthVader = StarWarsCharacter(name: "DarthVader", alias: "DarthVader", image: UIImage(named:"darthVader.jpg"), sound: "vader.caf", url: NSURL(string:"http://en.wikipedia.org/wiki/Darth_Vader"))
        var palpatine = StarWarsCharacter(name: "Palpatine", alias: "Palpatine", image: UIImage(named:"palpatine.jpg"), sound: "palpatine.caf", url: NSURL(string: "http://es.wikipedia.org/wiki/Palpatine"))
        var r2d2 = StarWarsCharacter(name: "R2-D2", alias: "R2-D2", image: UIImage(named: "R2-D2.jpg"), sound: "R2-D2.caf", url: NSURL(string: "http://es.wikipedia.org/wiki/R2-D2"))
        var tarkin = StarWarsCharacter(name: "Tarking", alias: "Tarking", image: UIImage(named: "tarkin.jpg"), sound: "tarkin.caf", url: NSURL(string: "http://en.wikipedia.org/wiki/Grand_Moff_Tarkin"))
        var yoda = StarWarsCharacter(name: "Yoda", alias: "Yoda", image: UIImage(named: "yoda.jpg"), sound: "yoda.caf", url: NSURL(string: "http://en.wikipedia.org/wiki/Yoda"))
        
        // Creación del universo de los personajes
        
        var universe = StarWarsUniverse()
        
        // Se añaden los personajes a sus grupos
        
        universe.addImperialCharacter(c3po)
        universe.addImperialCharacter(chewbacca)
        universe.addImperialCharacter(yoda)
        universe.addImperialCharacter(tarkin)
        
        universe.addRebelCharacter(darthVader)
        universe.addRebelCharacter(palpatine)
        universe.addRebelCharacter(r2d2)
        
        var universeVC = UniverseViewController(model: universe)
        var universeNC = UINavigationController(rootViewController: universeVC)
        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad{
            
            // Pantalla Grande
           
            // Recupero la selección del usuario
            
            var nc : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            var section : Int?
            var row : Int?
            
            var currentCharacter : StarWarsCharacter
            
            if let value = nc.objectForKey("section") as? Int{
                
                section = nc.objectForKey("section") as? Int
                row = nc.objectForKey("row") as? Int
                
                if section == 1{
                    currentCharacter = universe.rebelAtIndex(row!)
                }else{
                    currentCharacter = universe.imperialAtIndex(row!)
                }
            }else{
                currentCharacter = c3po
            }
            
            var characterVC = CharacterViewController(model: currentCharacter)
            
            // NavigationControllers
            
            var characterNC = UINavigationController(rootViewController: characterVC)
            
            // Split
            
            var splitVC = UISplitViewController()
            splitVC.viewControllers = [universeNC, characterNC]
            
            // Asignacion delegados
            
            universeVC.delegate = characterVC
            splitVC.delegate = characterVC
            
            window?.rootViewController = splitVC
            
        }else{
            
            // Pantalla Pequeña
            
            universeVC.delegate = universeVC
            
            window?.rootViewController = universeNC
            
        }
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


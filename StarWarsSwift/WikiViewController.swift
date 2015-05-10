//
//  WikiViewController.swift
//  StarWarsSwift
//
//  Created by Pawel Walicki on 10/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

import UIKit

class WikiViewController: UIViewController, UIWebViewDelegate{

    var model : StarWarsCharacter

    @IBOutlet weak var pdfView: UIWebView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    init(model : StarWarsCharacter){
        
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = model.name as String
        
    }
    

    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("WikiViewController", owner: self, options: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        pdfView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tableSelectChange:", name: "didSelectChange", object: nil)
        
        syncViewMode()
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    func tableSelectChange(notification: NSNotification) {
        
        let userInfo:Dictionary<String,StarWarsCharacter!> = notification.userInfo as! Dictionary<String,StarWarsCharacter!>
        
        self.model = userInfo["character"]!
        
        syncViewMode()
        
    }

    func syncViewMode()->(){
        
        self.title = self.model.name as String
        
        if let value = self.model.url{
            let requestObj = NSURLRequest(URL: self.model.url!);
            
            self.pdfView.loadRequest(requestObj)
    
        }

    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        println("start")
        self.activityView.hidden = false
        self.activityView.startAnimating()
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        println("stop")
        self.activityView.hidden = true
        self.activityView.stopAnimating()
        
    }
    
}

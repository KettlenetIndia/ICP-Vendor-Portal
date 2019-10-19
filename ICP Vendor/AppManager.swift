//
//  AppManager.swift
//  ivory
//
//  Created by Varun on 07/10/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import UIKit

class AppManager: NSObject
{
  static let shared =  AppManager()
    var toppadding =  CGFloat()
    var bottompadding = CGFloat()
    var leftpadding = CGFloat()
    var rightpadding = CGFloat()
    var reachbility : Reachability?
    var parentController : UIViewController?
    
    func updatechildview(view:UIView, childview:UIView)
    {
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let window =   UIApplication.shared.keyWindow
        
        toppadding = window?.safeAreaInsets.top ?? 0;
        bottompadding = window?.safeAreaInsets.bottom ?? 0
        leftpadding = window?.safeAreaInsets.left ?? 0;
        rightpadding = window?.safeAreaInsets.right ?? 0;
    
        if bottompadding == 0 && toppadding == 0
        {
            toppadding = 20
        }
        childview.frame = CGRect(x: leftpadding, y: toppadding, width:view.frame.size.width-rightpadding-leftpadding, height: view.frame.size.height-bottompadding-toppadding)
   

    
    }
    func createreachbility()
    {
        do{
             reachbility = try Reachability.init()
            startnotifier()
        }
       catch
       {
        print(error)
        }
    }
    func startnotifier() {
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(self.reachabilityChanged),
        name: .reachabilityChanged,
          object: reachbility)
        do
             {
                try reachbility!.startNotifier()
             }
             catch
             {
             print(error)
             }
        
    }
    

  @objc  func reachabilityChanged(notification: Notification)
  {
     let reachability = notification.object as! Reachability ;
     let controller =  parentController as! ViewController
    controller.detectconnection(reach: reachability)
    
    }
    
    
   
    func updatechildframe(size:CGSize, childview:UIView , parentview:UIView)
     {
            let window =   UIApplication.shared.keyWindow
             toppadding = window?.safeAreaInsets.top ?? 0;
             bottompadding = window?.safeAreaInsets.bottom ?? 0
             leftpadding = window?.safeAreaInsets.left ?? 0;
             rightpadding = window?.safeAreaInsets.right ?? 0;
            childview.frame = CGRect(x:leftpadding, y: toppadding, width:size.width-(rightpadding+leftpadding), height: size.height-(bottompadding+toppadding))
    }
    

}

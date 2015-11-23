//
//  EditionViewController.swift
//  Brindle
//
//  Created by Виталий Волков on 13.11.15.
//  Copyright © 2015 Виталий Волков. All rights reserved.
//

import UIKit

class EditionViewController: UIViewController {
    
    @IBOutlet weak var web: UIWebView!
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        web.scrollView.bounces = false;
        self.navigationController!.navigationBar.alpha = 0.0
        print(name!)
        let localfilePath = NSBundle.mainBundle().URLForResource(name!, withExtension: "html");
        print(localfilePath)
        let myRequest = NSURLRequest(URL: localfilePath!);
        web.loadRequest(myRequest);
        
        


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.alpha = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

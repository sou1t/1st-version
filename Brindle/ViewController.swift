//
//  ViewController.swift
//  Brindle
//
//  Created by Виталий Волков on 13.11.15.
//  Copyright © 2015 Виталий Волков. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import ActionButton


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var actionButton: ActionButton!
    
    @IBOutlet weak var DownloadTest: UIButton!
    
    var arr: [String] = []
    var name: String?{
        get
        {
            return NSUserDefaults.standardUserDefaults().objectForKey("name") as? String
        }
        set
        {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "name")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.progress.progress = 0.0
        arr = ["BRINDLEAUGUST.png", "2.png", "3.png", "4.png", "5.png"];
        self.navigationController!.navigationBar.alpha = 0.0
        let twitterImage = UIImage(named: "twitter_icon.png")!
        let instImage = UIImage(named: "instagram_logo.png")!
        let vkImage = UIImage(named: "vk_logo.png")!
        let fbImage = UIImage(named: "fb_logo.png")!
        let icon = UIImage(named: "info44.png")!
        let close = UIImage(named: "close33.png")!
        
        let twitter = ActionButtonItem(title: nil, image: twitterImage)
        twitter.action = { item in print("Twitter..."); UIApplication.sharedApplication().openURL(NSURL(string:"http://twitter.com/brindleofficial")!) }
        
        let instagram = ActionButtonItem(title: nil, image: instImage)
        instagram.action = { item in print("Insta..."); UIApplication.sharedApplication().openURL(NSURL(string:"http://instagram.com/brindleofficial")!) }
        
        let facebook = ActionButtonItem(title: nil, image: fbImage)
        facebook.action = { item in print("Facebook..."); UIApplication.sharedApplication().openURL(NSURL(string:"http://facebook.com/brindleofficial")!) }
        
        let vk = ActionButtonItem(title: nil, image: vkImage)
        vk.action = { item in print("VK..."); UIApplication.sharedApplication().openURL(NSURL(string:"http://vk.com/brindleofficial")!) }
        
        
        
        actionButton = ActionButton(attachedToView: self.view, items: [vk, twitter, facebook, instagram])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setImage(icon, forState: .Normal)
        actionButton.setImage(close, forState: .Selected)
        
        
        actionButton.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha:1.0)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController!.navigationBar.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //метод нажатия кнопки скачивания
    @IBAction func DownloadClick(sender: AnyObject) {
        
        
        
    }
    
    @IBOutlet weak var progress: UIProgressView!
        
    

    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
    @IBAction func DownloadTest(sender: AnyObject)
    {
        Alamofire.download(.GET, "http://mirror.internode.on.net/pub/test/5meg.test5", destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                print(totalBytesRead)
                
                // This closure is NOT called on the main queue for performance
                // reasons. To update your ui, dispatch to the main queue.
                dispatch_async(dispatch_get_main_queue()) {
                    self.progress.setProgress(Float(totalBytesRead)/Float(totalBytesExpectedToRead), animated: true)
                    print("Total bytes read on main queue: \(totalBytesRead)")
                }
            }
            .response { _, _, _, error in
                if let error = error {
                    print("Failed with error: \(error)")
                } else {
                    print("Downloaded file successfully")
                }
        }
        
        
    }
    
    
    //метод задает кол-во ячеек для вывода на экран
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    //метод отображения ячейки
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MagazineViewCell
        cell.Image.image = UIImage(named: arr[indexPath.row])
        return cell
    }
    //метод, определяющий момент выбора ячейки
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let filename: NSString = arr[indexPath.row]
        let pathPrefix = filename.stringByDeletingPathExtension
        name = pathPrefix
        
        performSegueWithIdentifier("showWeb", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWeb" {
            let vc = segue.destinationViewController as? EditionViewController
            vc?.name = name!
        }
    }


}


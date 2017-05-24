//
//  ViewController.swift
//  ok
//
//  Created by suryasoft konsultama on 5/23/17.
//  Copyright © 2017 DavidValentino. All rights reserved.
//

import UIKit

enum MyColor{
    case red
    case blue
    case black
    case purple
    
    func getColorBackground()->UIColor{
        switch self{
        case .red:
            return UIColor(red: 1.0, green: 248/255.0, blue: 244/255.0, alpha: 1.0)
            
            
        case .blue:
            return UIColor(red: 247/255.0, green: 248/255.0, blue: 255/255.0, alpha: 1.0)
            
        case .black:
            return UIColor(red: 249/255.0, green: 249/255.0, blue: 249/255.0, alpha: 1.0)
            
        case .purple:
            return UIColor(red: 254/255.0, green: 247/255.0, blue: 255/255.0, alpha: 1.0)
        }
    }
    func getColorText()->UIColor{
        switch self{
        case .red:
            return UIColor(red: 127/255.0, green: 99/255.0, blue: 9/255.0, alpha: 1.0)
            
            
        case .blue:
            return UIColor(red: 99/255.0, green: 99/255.0, blue: 127/255.0, alpha: 1.0)
            
        case .black:
            return UIColor(red: 99/255.0, green: 99/255.0, blue: 99/255.0, alpha: 1.0)
            
        case .purple:
            return UIColor(red: 120/255.0, green: 104/255.0, blue: 124/255.0, alpha: 1.0)
        }

    }
    mutating func setRandom(){
        let randomValue:Int = Int(arc4random_uniform(4))
        var new:MyColor
        switch randomValue{
        case 0:
            new = .red
            break
        case 1:
            new = .blue
            break
        case 2:
            new = .black
            break
            
        case 3:
            new = .purple
            break
            
        default:
            new = .red
        }
        
        if self == new{
            setRandom()
        }else{
            self = new
        }
        
    }
}

class ViewController: UIViewController {

    var _mainColor:MyColor = .red
    var _labelJoke: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        var atributed: NSMutableAttributedString = NSMutableAttributedString(string: "hello hello hello hellohello  hello hello hello hello hello hello hello hello hello v hello hellohello hello hello")
        var paragraph: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraph.lineSpacing = 10.0
        //paragraph.firstLineHeadIndent = 5.0
        atributed.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSMakeRange(0,atributed.string.characters.count))
        label.attributedText = atributed
        label.textAlignment = NSTextAlignment.center
   
        return label
    }()
    lazy var _buttonRefresh:UIButton = {
       
        let button: UIButton = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Refresh", for: .normal)
        button.addTarget(self, action: #selector(refreshJoke(sender:)), for: .touchUpInside)
    
        
        
        return button
    }()
    let _activityIndicator: UIActivityIndicatorView = {
        let temp: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        temp.hidesWhenStopped = true
//        temp.isHidden = true
        temp.translatesAutoresizingMaskIntoConstraints = false
        
        return temp
    }()
    let _api:CJSONDownloader = CJSONDownloader(url: "http://api.yomomma.info/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshJoke(sender: nil)
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    override func viewDidLayoutSubviews() {
        super.view.addSubview(_labelJoke)
        super.view.addSubview(_activityIndicator)
        super.view.addSubview(_buttonRefresh)
        
        
        NSLayoutConstraint.activate([
                _labelJoke.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
                _labelJoke.rightAnchor.constraint(equalTo: super.view.rightAnchor, constant: -16),
                _labelJoke.topAnchor.constraint(equalTo: super.topLayoutGuide.bottomAnchor, constant: 30),
            
            
                _activityIndicator.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
                _activityIndicator.centerYAnchor.constraint(equalTo: super.view.centerYAnchor),
                
                
                _buttonRefresh.bottomAnchor.constraint(equalTo: super.view.bottomAnchor, constant: -42),
                _buttonRefresh.centerXAnchor.constraint(equalTo: super.view.centerXAnchor, constant: 0)
                
                
                
               
            ])
 
        
    }
    
    func refreshJoke(sender: UIButton?){
        
        
        
        _activityIndicator.startAnimating()
        
        let closure = {(json: [String:AnyObject]) -> Void in
            let attributedText :NSMutableAttributedString? = self._labelJoke.attributedText as? NSMutableAttributedString
            guard attributedText != nil else { return }
            
            DispatchQueue.main.async {

                self._labelJoke.attributedText = NSAttributedString(string: json["joke"] as? String ?? "default", attributes: self._labelJoke.attributedText!.attributes(at: 0, effectiveRange: nil))
                self._activityIndicator.stopAnimating()
                self._mainColor.setRandom()
                super.view.backgroundColor = self._mainColor.getColorBackground()
                self._labelJoke.textColor = self._mainColor.getColorText()
                self._buttonRefresh.tintColor = self._mainColor.getColorText()
            }
            
//            
//
//            sleep(2)
//            DispatchQueue.main.asyncAfter(deadline: .now()){
//                
//                
//                
//            }
        }
        
        
        
        _api.getTask(completionHandler: closure)
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


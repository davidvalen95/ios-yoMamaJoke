//
//  ViewController.swift
//  ok
//
//  Created by suryasoft konsultama on 5/23/17.
//  Copyright © 2017 DavidValentino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    let _api:CJSONDownloader = CJSONDownloader(url: "http://api.yomomma.info/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshJoke(sender: nil)
        
        
    }
    override func viewDidLayoutSubviews() {
        super.view.addSubview(_buttonRefresh)
        super.view.addSubview(_labelJoke)
        NSLayoutConstraint.activate([
                _buttonRefresh.bottomAnchor.constraint(equalTo: super.view.bottomAnchor, constant: -16),
                _buttonRefresh.centerXAnchor.constraint(equalTo: super.view.centerXAnchor, constant: 0),
                
                
                
                _labelJoke.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
                _labelJoke.rightAnchor.constraint(equalTo: super.view.rightAnchor, constant: -16),
                _labelJoke.topAnchor.constraint(equalTo: super.topLayoutGuide.bottomAnchor, constant: 30)
            ])
        
    }
    func refreshJoke(sender: UIButton?){
        let closure = {(json: [String:AnyObject]) -> Void in
            let attributedText :NSMutableAttributedString? = self._labelJoke.attributedText as? NSMutableAttributedString
            guard attributedText != nil else { return }
            
            DispatchQueue.main.async {

                self._labelJoke.attributedText = NSAttributedString(string: json["joke"] as? String ?? "default", attributes: self._labelJoke.attributedText!.attributes(at: 0, effectiveRange: nil))}
        }
        _api.getTask(completionHandler: closure)
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


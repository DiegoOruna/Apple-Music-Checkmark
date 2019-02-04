//
//  ViewController.swift
//  Apple Music Checkmark
//
//  Created by Adrian Navarro on 1/31/19.
//  Copyright © 2019 Adrian Navarro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    
    }
    
    
    func setupView() {
        
        //Setup Buttons with Constraints & Actions
        self.view.addSubview(button)
        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        button.addTarget(self, action: #selector(completeButtonClicked(sender:)), for: .touchUpInside)

        self.view.addSubview(errorButton)
        errorButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        errorButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        errorButton.addTarget(self, action: #selector(errorButtonClicked(sender:)), for: .touchUpInside)
        
        //Setup Message Label
        self.completionAlertView.addSubview(self.messageLabel)
        self.messageLabel.topAnchor.constraint(equalTo: self.completionAlertView.topAnchor, constant: 212).isActive = true
        self.messageLabel.leadingAnchor.constraint(equalTo: self.completionAlertView.leadingAnchor, constant: 4).isActive = true
        self.messageLabel.trailingAnchor.constraint(equalTo: self.completionAlertView.trailingAnchor, constant: 4).isActive = true
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    @objc func completeButtonClicked(sender: UIButton) {
        showCheckMark(message: "Added To Library")
        
    }
    
    @objc func errorButtonClicked(sender: UIButton) {
        showError(message: "Error Adding To Library")
    }
    
    
 

    
    func showCheckMark(message: String) {
        self.view.addSubview(completionAlertView)
        messageLabel.text = message
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.completionAlertView.alpha = 1
            self.view.layoutIfNeeded()
        }) { (done) in
            self.layer.path = self.successPath.cgPath
            self.completionAlertView.layer.addSublayer(self.layer)
            self.alertViewAnimation.duration = 0.24
            self.layer.add(self.alertViewAnimation, forKey: "line")
        }
    }
    
    
    
    
    func showError(message: String) {
        self.view.addSubview(completionAlertView)
        messageLabel.text = message
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.completionAlertView.alpha = 1
            self.view.layoutIfNeeded()
        }) { (done) in
            self.layer.path = self.errorPath.cgPath
            self.completionAlertView.layer.addSublayer(self.layer)
            self.alertViewAnimation.duration = 0.3
            self.layer.add(self.alertViewAnimation, forKey: "line")
        }
        
    }
    
    
    
    func closeAlert() {
        UIView.animate(withDuration: 0.2, animations: {
            self.completionAlertView.alpha = 0.2
            self.view.layoutIfNeeded()
        }) { (complete) in
            self.layer.removeFromSuperlayer()
            self.completionAlertView.removeFromSuperview()
        }
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       closeAlert()
    }
    
    
    
    let completionAlertView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 62, y: 272.5, width: 250, height: 267)
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.00)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.alpha = 0
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 42, y: 212, width: 0, height: 0)
        label.sizeToFit()
        label.text = "Added To Library"
        label.font = UIFont(name: "Helvetica-Medium", size: 21)
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        label.textColor = UIColor(red: 0.349, green: 0.349, blue: 0.349, alpha: 1.00)
        label.textAlignment = .center
        return label
    }()
    
    
    let layer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor(red: 0.349, green: 0.349, blue: 0.349, alpha: 1.00).cgColor
        layer.lineWidth = 9
        layer.cornerRadius = 4
        layer.fillColor = nil
        layer.lineCap = .round
        layer.lineJoin = .round
        return layer
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Check", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let errorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Error", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let alertViewAnimation: CABasicAnimation = {
        let animation =  CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.24
        animation.autoreverses = false
        animation.repeatCount = 0
        return animation
    }()
    let errorPath : UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:92 , y: 84))
        path.addLine(to: CGPoint(x: 158, y: 150))
        path.move(to: CGPoint(x:158 , y: 84))
        path.addLine(to: CGPoint(x: 92, y: 150))
        return path
    }()
    let successPath: UIBezierPath = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:92 , y: 120))
        path.addLine(to: CGPoint(x: 125, y: 150))
        path.addLine(to: CGPoint(x: 186, y: 90))
        return path
    }()



}



//
//  Extension.swift
//  Captivation
//
//  Created by Brainstorm Jitesh on 27/06/18.
//  Copyright © 2018 Brainstorm. All rights reserved.
//

import Foundation
import UIKit


// MARK:-  Sequence
extension Sequence where Iterator.Element == UIView {
    
    func setRound() {
        self.forEach { (v) in
            v.setRound()
        }
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        self.forEach { (v) in
            v.setCornerRadius(radius)
        }
    }
    
    func setRoundBorder(_ width: CGFloat, _ color: String) {
        self.forEach { (v) in
            v.setRoundBorder(width, color)
        }
    }
    
    func setRoundBorder(_ width: CGFloat, _ color: String, _ cornerRadius: CGFloat) {
        self.forEach { (v) in
            v.setBorder(width, color)
            v.setCornerRadius(cornerRadius)
        }
    }
}

extension Sequence where Iterator.Element == UITextField {
    
    func setCornerRadius(_ radius: CGFloat) {
        self.forEach { (v) in
            v.setCornerRadius(radius)
        }
    }
    
    func setRoundBorder(_ width: CGFloat, _ color: String) {
        self.forEach { (v) in
            v.setRoundBorder(width, color)
        }
    }
    
    func setRoundBorder(_ width: CGFloat, _ color: String, _ cornerRadius: CGFloat) {
        self.forEach { (v) in
            v.setBorder(width, color)
            v.setCornerRadius(cornerRadius)
        }
    }
    
    func setBlankLeftView(_ width: CGFloat) {
        self.forEach { (v) in
            v.setBlankLeftView(width)
        }
    }
    
    func setLeftView(_ image: UIImage, _ width: CGFloat, _ imageWidth: CGFloat) {
        self.forEach { (v) in
            v.setLeftView(image, width, imageWidth)
        }
    }
    
    func setRightView(_ image: UIImage, _ width: CGFloat, _ imageWidth: CGFloat) {
        self.forEach { (v) in
            v.setRightView(image, width, imageWidth)
        }
    }
}


// MARK:-
// MARK:-  UIViewControler
extension UIViewController {
    
    func alertWith(_ title: String = "Demo", message: String, doneTitle:String? = "OK", cancelTitle:String? = "Cancel", doneAction:(()->())? = nil, cancelAction:(()->())? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: doneTitle, style: .default, handler: { (action) in
            if doneAction != nil {
                doneAction!()
            }
        }))
        
        if cancelAction != nil {
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action) in
                cancelAction!()
            }))
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func errorAlert(_ title: String = "Demo", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func successAlert(_ title: String = "Demo", message: String, doneAction:(()->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if doneAction != nil {
                doneAction!()
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}



// MARK:-
// MARK:-  UIView
extension UIView {
    
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func setRound() {
        self.setCornerRadius(self.frame.width/2)
    }
    
    func setRoundBorder(_ width: CGFloat, _ color: String) {
        setRound()
        setBorder(width, color)
    }
    
    func setBorder(_ width: CGFloat, _ color: String) {
        self.layer.borderColor = UIColor(color).cgColor
        self.layer.borderWidth = width
    }
    
    func setBorder(_ width: CGFloat, _ color: String, _ cornerRadius: CGFloat) {
        self.layer.borderColor = UIColor(color).cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
    }
    
    func setShadow(_ radius: CGFloat, _ width: CGFloat, _ height: CGFloat, _ color:String = "686868", _ opacity: Float = 1.0) {
        
        self.layer.shadowColor = UIColor(color).cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    func Set_Corner(_ width:CGFloat,_ height:CGFloat, _ Corners: UIRectCorner,_ radius: CGFloat, borderWidth: CGFloat = 0.0, borderColor color: String = "ffffff") {
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.borderColor = UIColor(color).cgColor
        rectShape.borderWidth = borderWidth
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: Corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = rectShape
    }
    
    func Set_Corner_image(width:CGFloat,height:CGFloat,Corners:UIRectCorner) {
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: Corners, cornerRadii: CGSize(width: width, height: height)).cgPath
        self.layer.mask = rectShape
        
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
    
    func applyGradient1(colours: [UIColor]) -> Void {
        self.applyGradient1(colours: colours, locations: [0.2,0.5,1.0])
    }
    
    func TextGradient(colours: [UIColor]) -> Void {
        self.applyGradient1(colours: colours, locations: [0.2,0.5,1.0])
    }
    
    func applyGradient1(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colours.map { $0.cgColor }
        gradient.frame = self.bounds
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
    
    var Getwidth : CGFloat {
        get { return self.frame.size.width  }
        set { self.frame.size.width = newValue }
    }
    
    var Getheight : CGFloat {
        get { return self.frame.size.height  }
        set { self.frame.size.height = newValue }
    }
    
    var Getsize:       CGSize  { return self.frame.size}
    
    var Getorigin:     CGPoint { return self.frame.origin }
    var Getx : CGFloat {
        get { return self.frame.origin.x  }
        set { self.frame.origin.x = newValue }
    }
    
    var Gety : CGFloat {
        get { return self.frame.origin.y  }
        set { self.frame.origin.y = newValue }
    }
    
    var Getleft:       CGFloat { return self.frame.origin.x }
    var Getright:      CGFloat { return self.frame.origin.x + self.frame.size.width }
    var Gettop:        CGFloat { return self.frame.origin.y }
    var Getbottom:     CGFloat { return self.frame.origin.y + self.frame.size.height }
}

extension UIScreen {
    
    class var height : CGFloat {
        get { return UIScreen.main.bounds.height }
    }
    
    class var Width : CGFloat {
        get { return UIScreen.main.bounds.width }
    }
}



// MARK:-
// MARK:-  UIColor
extension UIColor {
    convenience init(_ hex:String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner            = Scanner(string: hex as String)
        
        if (hex.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}



//MARK:-
//MARK:-   String
extension String {
    
    var attributed : NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    var trimed: String {
        return self.replacingOccurrences(of: "-", with: "")
    }
    
    var isEmptyOrWhiteSpace : Bool {
        return self.isEmpty && (self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    var toDate: Date {
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyyy"
        return df.date(from: self)!
    }
    
    var isFutureDate: Bool {
        return self.toDate > Date()
    }
}


extension NSAttributedString {
    
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
    {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
}


//MARK:-
//MARK:-   Dateformatter
extension DateFormatter {
    
    func getMMMDateStringFrom(_ date: Date) -> String {
        
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyyy"
        return df.string(from: date)
    }
}

//MARK:-
//MARK:-    UIResponder
extension UIResponder {
    
    func firstAvailableViewController() -> UIViewController? {
        return self.traverseResponderChainForFirstViewController()
    }
    
    func traverseResponderChainForFirstViewController() -> UIViewController? {
        if let nextResponder = self.next {
            if nextResponder is UIViewController {
                return nextResponder as? UIViewController
            } else if nextResponder is UIView {
                return nextResponder.traverseResponderChainForFirstViewController()
            } else {
                return nil
            }
        }
        return nil
    }
}



//MARK:-
//MARK:-   UITextField
extension UITextField {
    
    func setBlankLeftView(_ width: CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightView(_ image: UIImage, _ width: CGFloat, _ imageWidth: CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.Getheight))
        let imgview = UIImageView(frame: CGRect(x: 5, y: 0, width: imageWidth, height: imageWidth))
        imgview.image = image
        imgview.center = paddingView.center
        paddingView.addSubview(imgview)
        self.rightView = paddingView
        self.rightViewMode = .always
        
        let tapOnImgview = UITapGestureRecognizer(target: self, action: #selector(tapOnImgView(_:)))
        tapOnImgview.numberOfTapsRequired = 1
        paddingView.addGestureRecognizer(tapOnImgview)
        
    }
    
    func setLeftView(_ image: UIImage, _ width: CGFloat, _ imageWidth: CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.Getheight))
        let imgview = UIImageView(frame: CGRect(x: 5, y: 0, width: imageWidth, height: imageWidth))
        imgview.image = image
        imgview.center = paddingView.center
        paddingView.addSubview(imgview)
        self.leftView = paddingView
        self.leftViewMode = .always
        
        let tapOnImgview = UITapGestureRecognizer(target: self, action: #selector(tapOnImgView(_:)))
        tapOnImgview.numberOfTapsRequired = 1
        paddingView.addGestureRecognizer(tapOnImgview)
        
    }
    
    @objc func tapOnImgView(_ recognizer: UITapGestureRecognizer) {
        self.becomeFirstResponder()
    }
}



class CircleView : UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setRound()
    }
}


class CircleImageView : UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setRound()
    }
}

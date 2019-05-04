//
//  SATextField.swift
//  Beginner-Constraints
//
//  Created by Sean Allen on 11/29/18.
//  Copyright © 2018 Sean Allen. All rights reserved.
//

import UIKit

@IBDesignable

class SATextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    
    private func setUpField() {
        tintColor             = .white
        textColor             = .white
        font                  = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 18)
        backgroundColor       = UIColor(white: 1.0, alpha: 0.0)
        autocorrectionType    = .no
        layer.cornerRadius    = 0.0
        clipsToBounds         = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont   = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 18)!
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.50),
             NSAttributedString.Key.font: placeholderFont])
        
        let indentView        = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        leftView              = indentView
        leftViewMode          = .always
    }
    override var tintColor: UIColor! {
        
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY)
        
        let path = UIBezierPath()
        
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 3.0
        
        tintColor.setStroke()
        
        path.stroke()
    }
    
}

//
//  UIFonts+Extensions.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit

extension UIFont {
    
    //MARK: - extraBold
    
    public class var extraBold28: UIFont {
        UIFont.extraBold(with: 28.0)
    }
    
    //MARK: - Bold
    
    public class var bold24: UIFont {
        UIFont.bold(with: 24.0)
    }
    
    //MARK: - regular
    public class var regular14: UIFont {
        UIFont.regular(with: 14.0)
    }

    
    // MARK: - Private helpers
    private enum FontStyle: String {
        case regular = "AmericanTypewriter"
        
        case medium = "AmericanTypewriter-Medium"
        case mediumItalic = "AmericanTypewriter-MediumItalic"
        
        case semibold = "AmericanTypewriter-SemiBold"
        case semiboldItalic = "AmericanTypewriter-SemiBoldItalic"
        
        case bold = "AmericanTypewriter-Bold"
        case boldItalic = "AmericanTypewriter-BoldItalic"
        
        case extraBold = "AmericanTypewriter-ExtraBold"
        case extraBoldItalic = "AmericanTypewriter-ExtraBoldItalic"
    }
    
    private static func extraBold(with size: CGFloat) -> UIFont {
        self.font(with: .extraBold, size: size)
    }
    
    private static func bold(with size: CGFloat) -> UIFont {
        self.font(with: .bold, size: size)
    }
    
    private static func semiboldItalic(with size: CGFloat) -> UIFont {
        self.font(with: .semiboldItalic, size: size)
    }
    
    private static func medium(with size: CGFloat) -> UIFont {
        self.font(with: .medium, size: size)
    }
    
    private static func mediumItalic(with size: CGFloat) -> UIFont {
        self.font(with: .mediumItalic, size: size)
    }
    
    private static func extraBoldItalic(with size: CGFloat) -> UIFont {
        self.font(with: .extraBoldItalic, size: size)
    }
    
    private static func regular(with size: CGFloat) -> UIFont {
        self.font(with: .regular, size: size)
    }
    
    private static func font(with style: FontStyle, size: CGFloat) -> UIFont {
        UIFont(name: style.rawValue, size: size)!
    }
    
}

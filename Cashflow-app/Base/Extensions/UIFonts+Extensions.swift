//
//  UIFonts+Extensions.swift
//  Cashflow-app
//
//  Created by Meitar Basson on 15/10/2020.
//

import UIKit

extension UIFont {
    
    //MARK: - Bold
    
    public class var bold12: UIFont {
        UIFont.bold(with: 12.0)
    }
    
    public class var bold15: UIFont {
        UIFont.bold(with: 15.0)
    }
    
    public class var bold20: UIFont {
        UIFont.bold(with: 20.0)
    }
    
    public class var bold24: UIFont {
        UIFont.bold(with: 24.0)
    }
    
    public class var bold28: UIFont {
        UIFont.bold(with: 28.0)
    }
    
    //MARK: - regular
    public class var regular8: UIFont {
        UIFont.regular(with: 8.0)
    }
    
    public class var regular14: UIFont {
        UIFont.regular(with: 14.0)
    }
    
    public class var regular24: UIFont {
        UIFont.regular(with: 24.0)
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
    
    private static func regular(with size: CGFloat) -> UIFont {
        self.font(with: .regular, size: size)
    }
    
    private static func font(with style: FontStyle, size: CGFloat) -> UIFont {
        UIFont(name: style.rawValue, size: size)!
    }
    
}

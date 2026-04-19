//
//  Font+Ext.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import UIKit
import SwiftUI

protocol SwiftUIFontConvertible {
    /// Make swift ui font.
    func asFont() -> Font
    /// Make swift ui font with given size.
    func asFont(size: CGFloat) -> Font
    
    func callAsFunction() -> Font
    func callAsFunction(size: CGFloat) -> Font
}

extension SwiftUIFontConvertible where Self: RawRepresentable, RawValue == String {
    func asFont() -> Font { asFont(size: 16) }
    func asFont(size: CGFloat) -> Font {
        Font.custom(rawValue, size: size)
    }
    func callAsFunction() -> Font { asFont() }
    func callAsFunction(size: CGFloat) -> Font { asFont(size: size) }
}

extension Font {
    enum Karla: String, SwiftUIFontConvertible {
        case bold = "Karla-Bold"
        case boldItalic = "Karla-BoldItalic"
        case extraBold = "Karla-ExtraBold"
        case extraBoldItalic = "Karla-ExtraBoldItalic"
        case extraLight = "Karla-ExtraLight"
        case extraLightItalic = "Karla-ExtraLightItalic"
        case italic = "Karla-Italic"
        case light = "Karla-Light"
        case lightItalic = "Karla-LightItalic"
        case medium = "Karla-Medium"
        case mediumItalic = "Karla-MediumItalic"
        case regular = "Karla-Regular"
        case semiBold = "Karla-SemiBold"
        case semiBoldItalic = "Karla-SemiBoldItalic"
        // ...
    }
    enum MarkaziText: String, SwiftUIFontConvertible {
        case bold = "MarkaziText-Bold"
        case medium = "MarkaziText-Medium"
        case regular = "MarkaziText-Regular"
        case semiBold = "MarkaziText-SemiBold"
        // ...
    }
}

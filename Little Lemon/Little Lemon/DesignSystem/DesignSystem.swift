//
//  DesignSystem.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

extension Font {
    enum DS {
        static var displayTitle: Font { .MarkaziText.medium(size: 64) }
        static var subtitle: Font { .MarkaziText.regular(size: 40) }
        static var leadText: Font { .Karla.medium(size: 18) }
        static var cta: Font { leadText }
        static var sectionTitle: Font { .Karla.extraBold(size: 20) }
        static var sectionSubtitle: Font { .Karla.extraBold(size: 16) }
        static var categoryTitle: Font { sectionSubtitle }
        static var cardTitle: Font { .Karla.bold(size: 16) }
        static var paragraphText: Font { .Karla.regular(size: 16) }
        static var highlightText: Font { .Karla.medium(size: 16) }
        static var captionText: Font { .Karla.regular(size: 14) }
    }
}

extension Color {
    
    enum DS {
        static var clear: Color { Color("designsystem/clear", bundle: .main) }
        static var highlightBlack: Color { Color("designsystem/highlightBlack", bundle: .main) }
        static var highlightWhite: Color { Color("designsystem/highlightWhite", bundle: .main) }
        static var primaryGreen: Color { Color("designsystem/primaryGreen", bundle: .main) }
        static var primaryYellow: Color { Color("designsystem/primaryYellow", bundle: .main) }
        static var secondaryPink: Color { Color("designsystem/secondaryPink", bundle: .main) }
        static var secondaryRed: Color { Color("designsystem/secondaryRed", bundle: .main) }
        static var white: Color { Color("designsystem/white", bundle: .main) }
    }
    
}

extension Text {
    func asLabelText() -> some View {
        font(.DS.highlightText)
            .foregroundStyle(Color.DS.highlightBlack)
    }
    
    func asErrorText() -> some View {
        font(.DS.captionText)
            .foregroundStyle(Color.DS.secondaryRed)
    }
}

//
//  DesignSystem.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI

extension Font {
    enum DesignSystem {
        static var displayTitle: Font { .MarkaziText.medium(size: 64) }
        static var subtitle: Font { .MarkaziText.regular(size: 40) }
        static var leadText: Font { .Karla.medium(size: 18) }
        static var cta: Font { leadText }
        static var sectionTitle: Font { .Karla.extraBold(size: 20) }
        static var categoryTitle: Font { .Karla.extraBold(size: 16) }
        static var cardTitle: Font { .Karla.bold(size: 16) }
        static var paragraphText: Font { .Karla.regular(size: 16) }
        static var highlightText: Font { .Karla.medium(size: 16) }
        static var captionText: Font { .Karla.regular(size: 14) }
    }
}

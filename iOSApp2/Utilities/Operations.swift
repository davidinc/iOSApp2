//
//  ImagePicker.swift
//  iOSApp2
//
//  Created by Dawit Chernet on 2026-06-05.
//

import SwiftUI

func + (left: CGSize, right: CGSize) -> CGSize {
    CGSize(width: left.width + right.width, height: left.height + right.height)
}

func * (left: CGSize, right: CGFloat) -> CGSize {
    CGSize(width: left.width * right, height: left.height * right)
}

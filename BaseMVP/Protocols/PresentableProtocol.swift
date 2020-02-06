//
//  PresentableProtocol.swift
//  BaseMVP
//
//  Created by Sanad Barjawi on 2/6/20.
//  Copyright © 2020 SanadBarjawi. All rights reserved.
//

import Foundation

public protocol Presentable {
    associatedtype View
    var view: View? {get}
    func getView() -> View?
    func attachView(_ view: View)
    func detachView()
}

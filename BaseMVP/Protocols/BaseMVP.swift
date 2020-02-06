//
//  BaseMVP.swift
//  BaseMVP
//
//  Created by Sanad Barjawi on 2/6/20.
//  Copyright © 2020 SanadBarjawi. All rights reserved.
//
import UIKit

open class BaseMVP<P: Presentable, V>: UIViewController {
    
    public var presenter: P?
    
    open func createPresenter() -> P? {
        return presenter
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
       presenter = createPresenter()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter = createPresenter()
    }
            
}

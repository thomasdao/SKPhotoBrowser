//
//  SKToolbar.swift
//  SKPhotoBrowser
//
//  Created by keishi_suzuki on 2017/12/20.
//  Copyright © 2017年 suzuki_keishi. All rights reserved.
//

import UIKit

// helpers which often used
private let bundle = Bundle(for: SKPhotoBrowser.self)

class SKToolbar: UIToolbar {
    var editButton: UIBarButtonItem!
    var toolActionButton: UIBarButtonItem!
    fileprivate weak var browser: SKPhotoBrowser?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, browser: SKPhotoBrowser) {
        self.init(frame: frame)
        self.browser = browser
        
        setupApperance()
        setupToolbar()
    }
    
    func animate(hidden: Bool) {
        UIView.animate(withDuration: 0.35) {
            let alpha: CGFloat = hidden ? 0.0 : 1.0
            self.alpha = alpha
        }
    }
}

private extension SKToolbar {
    func setupApperance() {
        backgroundColor = .clear
        clipsToBounds = true
        isTranslucent = true
        setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
    
        if #available(iOS 13.0, *) {
            let appearance = UIToolbarAppearance()
            appearance.configureWithTransparentBackground()
            standardAppearance = appearance
            compactAppearance = appearance
            if #available(iOS 15.0, *) {
                scrollEdgeAppearance = appearance
            }
        } else {
            isTranslucent = true
            setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
            setShadowImage(UIImage(), forToolbarPosition: .any)
        }
    }
    
    func setupToolbar() {
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: browser, action: #selector(SKPhotoBrowser.editButtonPressed))
        toolActionButton = UIBarButtonItem(barButtonSystemItem: .action, target: browser, action: #selector(SKPhotoBrowser.actionButtonPressed))
        
        editButton.tintColor = .white
        toolActionButton.tintColor = .white
        
        var items = [UIBarButtonItem]()
        items.append(editButton)
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        if SKPhotoBrowserOptions.displayAction {
            items.append(toolActionButton)
        }
        setItems(items, animated: false)
    }
    
    func setupActionButton() {
    }
}


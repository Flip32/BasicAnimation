//
//  SquareBehavior.swift
//  BasicAnimation
//
//  Created by Filipe Lopes on 14/10/21.
//

import UIKit

class SquareBehavior: UIDynamicBehavior {

    private var gravity: UIGravityBehavior
    private var collision: UICollisionBehavior
    
    override init() {
                
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        super.init()
        
        addChildBehavior(gravity)
        addChildBehavior(collision)
    }
    
    public func addItem(_ item: UIDynamicItem) {
        gravity.addItem(item)
        collision.addItem(item)
    }
    
    public func removeItem(_ item: UIDynamicItem) {
        gravity.removeItem(item)
        collision.removeItem(item)
    }
}

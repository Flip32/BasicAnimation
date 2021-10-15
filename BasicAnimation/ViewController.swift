//
//  ViewController.swift
//  BasicAnimation
//
//  Created by Filipe Lopes on 14/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var board: UIView! {
        didSet {
            animator = UIDynamicAnimator(referenceView: board)
            behavior = SquareBehavior()
            animator?.addBehavior(behavior!)
        }
    }
    
    private var animator: UIDynamicAnimator?
    private var behavior: SquareBehavior?
    private var squares = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onSquare(_ sender: UIButton) {
        var frame = CGRect(origin: .zero, size:CGSize(width: 30, height: 30))
        let x = arc4random() % UInt32(board.bounds.size.width)
        frame.origin.x = CGFloat(x)
        
        let square = UIView(frame: frame)
        square.backgroundColor = UIColor.cyan
        board.addSubview(square)
        squares.append(square)
        behavior?.addItem(square)
    }
    
    
    @IBAction func onExplode(_ sender: Any) {
        guard squares.count > 0 else { return }
        
        squares.forEach({behavior?.removeItem($0)})
        
        UIView.animate(withDuration: 1) {
            self.explodeSquares()
        } completion: { (finished) in
            self.squares.forEach({$0.removeFromSuperview()})
            self.squares.removeAll()
        }
    }
    
    private func explodeSquares(){
        for sq in self.squares {
            let x = arc4random() % UInt32(self.board.bounds.size.width * 5)
            let y = self.board.bounds.size.height
            sq.center = CGPoint(x: CGFloat(x), y: -y)
        }
    }
    
}


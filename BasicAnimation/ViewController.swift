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
            let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)) )
            board.isUserInteractionEnabled = true
            board.addGestureRecognizer(tap)
            animator = UIDynamicAnimator(referenceView: board)
            behavior = SquareBehavior()
            animator?.addBehavior(behavior!)
        }
    }
    
    private var animator: UIDynamicAnimator?
    private var behavior: SquareBehavior?
    private var squares = [UIView]()
    
    private func createSquare(at point: CGPoint) {
        let frame = CGRect(origin: point, size:CGSize(width: 30, height: 30))
        let square = UIView(frame: frame)
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        square.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        board.addSubview(square)
        squares.append(square)
        behavior?.addItem(square)
    }
    
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        let pointsXY = sender.location(in: board)
        createSquare(at: pointsXY)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSquare(_ sender: UIButton) {
        let x = arc4random() % UInt32(board.bounds.size.width)
        
        let point = CGPoint(x: Int(x), y: 0)
        createSquare(at: point)
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


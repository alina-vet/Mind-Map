//
//  CardView.swift
//  mindMap
//
//  Created by Алина Бондарчук on 10.11.2021.
//

import UIKit

protocol CardViewDelegate {
    func didSelect(_ card: CardView)
    func didEdit (_ card: CardView)
}

class CardView: UIView {

    @IBOutlet var cardView: UIView!
    @IBOutlet weak var cardLabel: UILabel!
    
    var lines = [LineView]()
    var delegate: CardViewDelegate?
    
    var xPos: CGFloat = 20.0
    
    init(_ atPoint: CGPoint) {
        let size: CGFloat = 80
        let frame = CGRect(x: atPoint.x-size/2, y: atPoint.y-size/2, width: 180, height: 100)
        super.init(frame: frame)
        
        commonInit()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPanInCard(_:)))
        self.addGestureRecognizer(pan)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapInCard(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapInCard(_:)))
        tap.require(toFail: doubleTap)
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: - Init From Xib
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
//MARK: - Gestures
    
    @objc func didPanInCard(_ gesture: UIPanGestureRecognizer) {
        print("didPan")
        if gesture.state == .changed {
            self.center = gesture.location(in: superview)
            //Uppdatera alla linjer
            for line in lines {
                line.update()
            }
        }   else if gesture.state == .began {
            superview?.bringSubviewToFront(self)
        }
    }
    
    @objc func didTapInCard(_ gesture: UITapGestureRecognizer) {
        print("did tap in bubble")
        guard  let card = gesture.view as? CardView else { return }
        if delegate != nil {
            delegate!.didSelect(card)
        }
    }
    
    @objc func didDoubleTapInCard(_ gesture: UITapGestureRecognizer) {
        print("did double tap in bubble")
        guard  let card = gesture.view as? CardView else { return }
        if delegate != nil {
            delegate!.didEdit(card)
        }
    }
    
//MARK: - Helper Methods
    
    func selected() {
        cardView.layer.borderWidth = 10
        cardView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func deselected() {
        cardView.layer.borderWidth = 0
    }
    
//    func delete() {
//        for line in lines {
//            line.removeFromSuperview()
//        }
//        removeFromSuperview()
//    }
    
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

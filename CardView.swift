//
//  CardView.swift
//  mindMap
//
//  Created by Алина Бондарчук on 09.12.2021.
//

import UIKit

protocol CardViewDelegate {
    func didSelect(_ card: CardView)
    func didEdit (_ card: CardView)
}

class CardView: UIView, UITextFieldDelegate {

    @IBOutlet var cardView: UIView!
    @IBOutlet weak var cardField: UITextField!
    
    var lines = [LineView]()
    var delegate: CardViewDelegate?
    var mindCard: MindMapViewController?
    
    init(_ atPoint: CGPoint) {
        let size: CGFloat = 80
        let frame = CGRect(x: atPoint.x - size / 2, y: atPoint.y  - size / 2, width: 180, height: 100)
        super.init(frame: frame)
        
        initViewFromXib()
        
        cardView.isUserInteractionEnabled = true
        let interaction = UIContextMenuInteraction(delegate: self)
        cardView.addInteraction(interaction)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPanInCard(_:)))
        self.addGestureRecognizer(pan)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapInCard(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapInCard(_:)))
        tap.require(toFail: doubleTap)
        self.addGestureRecognizer(tap)
        
        cardField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: - Init From Xib
    
    func initViewFromXib() {
        let viewFromXib = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as! UIView
        addSubview(viewFromXib)
    }
    
//MARK: - Gestures
    
    @objc func didPanInCard(_ gesture: UIPanGestureRecognizer) {
        print("did drug card")
        if gesture.state == .changed {
            self.center = gesture.location(in: superview)
            
            for line in lines {
                line.update()
            }
        }   else if gesture.state == .began {
            superview?.bringSubviewToFront(self)
        }
    }
    
    @objc func didTapInCard(_ gesture: UITapGestureRecognizer) {
        print("did tap in card")
        guard  let card = gesture.view as? CardView else { return }
        if delegate != nil {
            delegate!.didSelect(card)
        }
    }
    
    @objc func didDoubleTapInCard(_ gesture: UITapGestureRecognizer) {
        print("did double tap in card")
        guard  let card = gesture.view as? CardView else { return }
        if delegate != nil {
            delegate!.didEdit(card)
        }
    }
    
//MARK: - Helper Methods
    
    func selected() {
        cardView.layer.borderWidth = 5
        cardView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func deselected() {
        cardView.layer.borderWidth = 0
    }
    
    func deleteTapped() {
        for line in lines {
            line.removeFromSuperview()
        }
        removeFromSuperview()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.isUserInteractionEnabled = false
        return true
    }
    
//MARK: - Notifocations
    
//    func registerForKeyboardNotifocations() {
//        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name., object: <#T##Any?#>)
//    }
//
//    @objc func kbWillShow() {
//
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

extension CardView: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu? in
            let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil"), handler: { [self] _ in
                
                cardField.isUserInteractionEnabled = true
                cardField.resignFirstResponder()
                cardField.becomeFirstResponder()
            })
            
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { [self] _ in
                deleteTapped()
            })
            
            return  UIMenu(title: "Edit", image: nil, identifier: nil, options: [], children: [rename, delete])
        }
        return configuration
    }
}

/*
 guard let touch = touches.first else { return }
 let location = touch.location(in: view)
 */

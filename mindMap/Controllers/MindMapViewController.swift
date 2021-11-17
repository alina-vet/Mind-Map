//
//  MindMapViewController.swift
//  mindMap
//
//  Created by Алина Бондарчук on 08.11.2021.
//

import UIKit

class MindMapViewController: UIViewController, UIGestureRecognizerDelegate, CardViewDelegate {

    

    @IBOutlet weak var mainIdeaView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var mainIdeaLabel: UILabel!
    
    var mindIdea: String?
    //var otherIdeaLabels = [UILabel]()
    var selectedCard: CardView?
    var xPos: CGFloat = 20.0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let labelToLoad = mindIdea {
            mainIdeaLabel.text = labelToLoad
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Gestures
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: view)
//        let card = CardView(location)
//        card.delegate = self
//        view.addSubview(card)
//
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let card = touch.location(in: view)
//        if selectedCard == nil {
//            selectedCard = card
//    }
    
    //MARK: - CardViewDelegate
    
    func didSelect(_ card: CardView) {
        if selectedCard != nil {
            if card == selectedCard {
                
            } else {
                let line = LineView(from: selectedCard!, to: card)
                view!.insertSubview(line, at: 0)
                selectedCard?.lines.append(line)
                card.lines.append(line)
            }
            selectedCard?.deselected()
            selectedCard = nil
        } else {
            selectedCard = card
            selectedCard?.selected()
        }
    }
    
    func didEdit(_ card: CardView) {
        let ac = UIAlertController(title: "Enter new name", message: nil, preferredStyle: .alert)
                ac.addTextField { textField in
                    textField.keyboardType = .default
                    textField.clearButtonMode = .whileEditing
                    textField.textAlignment = .center
                    textField.text = card.cardLabel.text
                }
                ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { (action) in
                    let textField = ac.textFields![0] as UITextField
                    card.cardLabel.text = textField.text
                }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        print("did tap")
        if selectedCard != nil {
            selectedCard?.deselected()
            selectedCard = nil
        } else {
            let tapPoint = gesture.location(in: self.view)
            let card = CardView(tapPoint)
            card.delegate = self
            view!.addSubview(card)
        }
    }
    
    
//    @IBAction func addNewIdea(_ sender: Any) {
//        createL()
//        print("dbcsd")
//    }
    //MARK: Helper Methods
    
    func createL() {
        let cardView = CardView(frame: CGRect(x: xPos, y: mainIdeaLabel.center.y + 70, width: 180, height: 100))
        self.view.addSubview(cardView)
    }
        
//    @objc func createMind() -> UILabel {
//        let childMindLabel = UILabel()
//        childMindLabel.frame = CGRect(x: 50, y: 50, width: 180, height: 90)
//        childMindLabel.textAlignment = .center
//        childMindLabel.text = "New good idea"
//        childMindLabel.textColor = .white
//        childMindLabel.font = UIFont(name: "SF-Pro-Rounded-Semibold.otf", size: 24)
//        childMindLabel.backgroundColor = .systemGray3
//        childMindLabel.layer.masksToBounds = true
//        childMindLabel.layer.cornerRadius = 40
//        self.view.addSubview(childMindLabel)
//        otherIdeaLabels.append(childMindLabel)
//
//        createButton()
//        return childMindLabel
//    }
//
//    func createButton() {
//        let button = UIButton()
//        button.frame = CGRect(x: 50, y: 50, width: 30, height: 30)
//        button.backgroundColor = .cyan
//        button.layer.masksToBounds = true
//        button.layer.cornerRadius = 10
//        button.setImage(UIImage.init(systemName: "plus"), for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(createMind), for: .touchUpInside)
//        self.view.addSubview(button)
//    }
//
//    @objc func create() {
//            let childMindLabel = UILabel()
//            childMindLabel.frame = CGRect(x: xPos, y: mainIdeaLabel.center.y + 100, width: 180, height: 90)
//            xPos += childMindLabel.frame.size.width + 20.0
//            childMindLabel.textAlignment = .center
//            childMindLabel.text = "New good idea"
//            childMindLabel.textColor = .white
//            childMindLabel.font = UIFont(name: "SF-Pro-Rounded-Semibold.otf", size: 24)
//            childMindLabel.backgroundColor = .systemGray3
//            childMindLabel.layer.masksToBounds = true
//            childMindLabel.layer.cornerRadius = 40
//            self.view.addSubview(childMindLabel)
//            otherIdeaLabels.append(childMindLabel)
//
//        let button = UIButton()
//        button.frame = CGRect(x: childMindLabel.frame.midX - 20, y: childMindLabel.frame.midY + 30, width: 30, height: 30)
//        button.backgroundColor = .cyan
//        button.layer.masksToBounds = true
//        button.layer.cornerRadius = 10
//        button.setImage(UIImage.init(systemName: "plus"), for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(createMind), for: .touchUpInside)
//        self.view.addSubview(button)
//    }
//
//    @objc func renameLabel() {
//        let ac = UIAlertController(title: "Enter new name", message: nil, preferredStyle: .alert)
//        ac.addTextField { textField in
//            textField.keyboardType = .default
//            textField.clearButtonMode = .whileEditing
//            textField.textAlignment = .center
//        }
//        ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { _ in
//            guard let text = ac.textFields?[0].text else { return }
//            self.result = text
//            self.dragLabel.text = self.result
//        }))
//        present(ac, animated: true, completion: nil)
//    }
//
//    @objc func test() {
//        let ac = UIAlertController(title: "test", message: nil, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        present(ac, animated: true, completion: nil)
//    }
//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//
//  LineView.swift
//  mindMap
//
//  Created by Алина Бондарчук on 12.11.2021.
//

import UIKit

class LineView: UIView {
    
    var fromView: CardView?
    var toView: CardView?
    
    init(from: CardView, to: CardView) {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
        fromView = from
        toView = to
        update()
    }
    
    func update() {
        //Рассчитайте новый каркас и вызовите новый рисунок
        if fromView != nil && toView != nil {
            self.frame = fromView!.frame.union(toView!.frame)
            self.setNeedsDisplay()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        //Начальная точка кривой
        let startPoint = fromView!.center - frame.origin
        //Пункт назначения кривой
        let destination = toView!.center - frame.origin
        
        let controlVector = CGPoint(x: (destination.x - startPoint.x) * 0.5, y:0)
        path.move(to: startPoint) //Перейти к начальной точке
        // path.addLine(to: destination) // Создать линию до конечной точки
        path.addCurve(to: destination, controlPoint1: startPoint + controlVector, controlPoint2: destination - controlVector)
        path.lineWidth = 2.0
        UIColor.systemGray.setStroke()
        path.stroke()
    }
    
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

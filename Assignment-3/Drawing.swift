//
//  Drawing.swift
//  Assignment-3
//
//  Created by Dhruvil on 10/18/19.
//  Copyright © 2019 Dhruvil. All rights reserved.
//
import UIKit

struct Stroke
{
    let firstPoints : CGPoint
    let startPoint: CGPoint
    let radius: CGFloat
    let color: CGColor
}

class Drawing: UIView
{
    var strokes = [Stroke]()
    var circles = [CGPoint]()
    var radiuss = [CGFloat]()
    var color = [CGColor]()
    var index = [Int]()
    var directionX = [CGFloat]()
    var directionY = [CGFloat]()
    var lastPoint: CGPoint!
    var firstPoint: CGPoint!
    var strokeColor: CGColor = UIColor.black.cgColor
    var moveRadius: CGFloat!
    var dxx: CGFloat = 0
    var dyy: CGFloat = 0
    var time: Timer!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if Mode.counter == 1
        {
            guard let touch = touches.first else { return }
            let currentPoint = touch.location(in: self)
            lastPoint = currentPoint
            firstPoint = currentPoint
        }
        if Mode.counter == 2
        {
            guard let touch = touches.first else { return }
            let currentPoint = touch.location(in: self)
            index = []
            if circles.count != 0
            {
                for element in 0..<circles.count
                {
                    let radius = sqrt(pow((currentPoint.x - circles[element].x),2.0) + pow((currentPoint.y - circles[element].y),2.0))
                    if radius <= radiuss[element]
                    {
                        index.append(element)
                    }
                }
                if index.count != 0
                {
                    index.sort(by: >)
                    for i in index
                    {
                        circles.remove(at: i)
                        radiuss.remove(at: i)
                        color.remove(at: i)
                        directionX.remove(at: i)
                        directionY.remove(at: i)
                    }
                    redraw()
                }
            }
        }
        if Mode.counter == 3
        {
            guard let touch = touches.first else { return }
            let currentPoint = touch.location(in: self)
            if circles.count != 0
            {
                for element in 0..<circles.count
                {
                    let radius = sqrt(pow((currentPoint.x - circles[element].x),2.0) + pow((currentPoint.y - circles[element].y),2.0))
                    if radius <= radiuss[element]
                    {
                        lastPoint = circles[element]
                        moveRadius = radiuss[element]
                        firstPoint = circles[element]
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if Mode.counter == 1
        {
            guard let touch = touches.first else { return }
            let currentPoint = touch.location(in: self)
            let stroke = Stroke(firstPoints:firstPoint ,startPoint: lastPoint, radius: 10 + sqrt(pow((currentPoint.x - firstPoint.x),2.0) + pow((currentPoint.y - firstPoint.y),2.0)), color: strokeColor)
            strokes.append(stroke)
            lastPoint = currentPoint
            setNeedsDisplay()
        }
        if Mode.counter == 3
        {
            strokes = []
            guard let touch = touches.first else { return }
            let currentPoint = touch.location(in: self)
            for element in 0..<circles.count
            {
                if circles[element] == lastPoint
                {
                    circles[element] = currentPoint
                    lastPoint = currentPoint
                }
            }
            for i in 0..<circles.count
            {
                strokes.append(Stroke(firstPoints: circles[i], startPoint: circles[i], radius: radiuss[i], color: color[i]))
            }
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if Mode.counter == 1
        {
            guard let touch = touches.first else { return }
            let currentPoint = touch.location(in: self)
            let stroke = Stroke(firstPoints:firstPoint ,startPoint: lastPoint, radius: 10 + sqrt(pow((currentPoint.x - firstPoint.x),2.0) + pow((currentPoint.y - firstPoint.y),2.0)), color: strokeColor)
            strokes.append(stroke)
            circles.append(firstPoint)
            radiuss.append(10 + CGFloat(sqrt(pow((currentPoint.x - firstPoint.x),2.0) + pow((currentPoint.y - firstPoint.y),2.0))))
            color.append(strokeColor)
            directionX.append(dxx)
            directionY.append(dyy)
            lastPoint = nil
            firstPoint = nil
            setNeedsDisplay()
        }
        if Mode.counter == 3
        {
            guard let touch = touches.first else { return }
            let currentPoint = touch.location(in: self)
            if let start = firstPoint
            {
                dxx = currentPoint.x - start.x
                dyy = currentPoint.y - start.y
                for element in 0..<circles.count
                {
                    if circles[element] == lastPoint
                    {
                        circles[element] = currentPoint
                        lastPoint = currentPoint
                        directionX[element] = dxx/2
                        directionY[element] = dyy/2
                    }
                }
            }
            firstPoint = nil
            moveRadius = nil
            lastPoint = nil
            dxx = 0
            dyy = 0
            if time == nil
            {
                startTimer()
            }
        }
    }
    
    override func draw(_ rect: CGRect)
    {
        if let context:CGContext = UIGraphicsGetCurrentContext()
        {
            context.setLineWidth(10)
            for stroke in strokes
            {
                context.beginPath()
                let center = CGPoint(x: stroke.firstPoints.x, y: stroke.firstPoints.y)
                context.addArc(center: center, radius: stroke.radius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
                context.setFillColor(stroke.color)
                context.fillPath()
                context.strokePath()
            }
        }
    }
    
    func redraw()
    {
        strokes = []
        for element in 0..<circles.count
        {
            strokes.append(Stroke(firstPoints: circles[element], startPoint: circles[element], radius: radiuss[element], color: color[element]))
        }
        setNeedsDisplay()
    }
    
    func startTimer()
    {
        time = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block:
        { (timer) in
            self.update(timer: timer)
        })
    }
    func update(timer: Timer)
    {
        edgeDetection()
        for element in 0..<circles.count
        {
            circles[element] = CGPoint(x: circles[element].x + directionX[element],y: circles[element].y + directionY[element])
        }
        redraw()
    }
    func edgeDetection()
    {
        let viewWidth = bounds.width
        let viewHeigth = bounds.height
        for element in 0..<circles.count
        {
            let rightEdge = circles[element].x + radiuss[element]
            let leftEdge = circles[element].x - radiuss[element]
            let upperEdge = circles[element].y - radiuss[element]
            let lowerEdge = circles[element].y + radiuss[element]
            if leftEdge <= 0 || rightEdge >= viewWidth
            {
                directionX[element] = -1 * (directionX[element])
            }
            if upperEdge <= 0 || lowerEdge >= viewHeigth
            {
                directionY[element] = -1 * (directionY[element])
            }
        }
    }
}


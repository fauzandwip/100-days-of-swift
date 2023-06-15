//
//  ViewController.swift
//  Project27
//
//  Created by Fauzan Dwi Prasetyo on 15/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
        
    }
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerBoard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCheckerBoard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0..<rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0..<256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 150, y: 50))
            
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
//            let mouse = UIImage(named: "mouse")
//            mouse?.draw(at: CGPoint(x: 150, y: 50))
        }
        
        imageView.image = image
    }
    
    func drawStar() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            
            ctx.cgContext.translateBy(x: 128, y: 128)

            let poinsOnStar = 5
            let startAngel: CGFloat = -CGFloat.pi / 2
            let innerRadius: Double = 512 / 5
            let outerRadius:Double = 512 / 2
            
            let angleIncrement = CGFloat.pi * 2 / CGFloat(poinsOnStar * 2)
            
            for i in 0...poinsOnStar * 2 {
                let radius = (i % 2) == 0 ? outerRadius : innerRadius
                let angle = startAngel + CGFloat(i) * angleIncrement
                
                let x = 256.0 / 2 + radius * cos(Double(angle))
                let y = 256.0 / 2 + radius * sin(Double(angle))
                
                if i == 0 {
                    ctx.cgContext.move(to: CGPoint(x: x, y: y))
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: x, y: y))
                }
            }
//            ctx.cgContext.move(to: CGPoint(x: 100, y: 100))
//            ctx.cgContext.addLine(to: CGPoint(x: 150, y: 250))
//            ctx.cgContext.addLine(to: CGPoint(x: 0, y: 150))
//
//            ctx.cgContext.rotate(by: .pi / 2)
//            ctx.cgContext.move(to: CGPoint(x: 150, y: 0))
//            ctx.cgContext.addLine(to: CGPoint(x: 250, y: 150))
//            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 100))
//            ctx.cgContext.addLine(to: CGPoint(x: -50, y: 200))
            
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }

//    func drawExp() {
//
//        // Define the size of the canvas
//        let canvasSize = CGSize(width: 512, height: 512)
//
//        // Create a renderer for the canvas
//        let renderer = UIGraphicsImageRenderer(size: canvasSize)
//
//        // Create the image context
//        let image = renderer.image { context in
//
//            context.cgContext.translateBy(x: 256, y: 256)
//            context.cgContext.rotate(by: .pi / 2)
//            // Define the starting point for the path
//            let startPoint = CGPoint(x: 50, y: 50)
//
//            // Create a UIBezierPath
//            let path = UIBezierPath()
//
//            // Move to the starting point
//            path.move(to: startPoint)
//
//            // Add the line segments to form the letters
//            path.addLine(to: CGPoint(x: 80, y: 10))
//            path.addLine(to: CGPoint(x: 110, y: 50))
//            path.addLine(to: CGPoint(x: 140, y: 10))
//            path.addLine(to: CGPoint(x: 170, y: 50))
//
//            // Set the line width and stroke color
//            path.lineWidth = 3.0
//            UIColor.black.setStroke()
//
//            // Stroke the path
//            path.stroke()
//
//
//        }
//
//        // Display the image
//        imageView.image = image
//    }
    
    func drawTWIN() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let contextT = ctx.cgContext
            contextT.translateBy(x: 0, y: 256)
            
            // T letter
            contextT.move(to: CGPoint(x: 0, y: 0))
            contextT.addLine(to: CGPoint(x: 50, y: 0))
            contextT.move(to: CGPoint(x: 25, y: 0))
            contextT.addLine(to: CGPoint(x: 25, y: 50))
            
            // W letter
            contextT.move(to: CGPoint(x: 75, y: 0))
            contextT.addLine(to: CGPoint(x: 100, y: 50))
            contextT.addLine(to: CGPoint(x: 125, y: 10))
            contextT.addLine(to: CGPoint(x: 150, y: 50))
            contextT.addLine(to: CGPoint(x: 175, y: 0))
            
            // I letter
            contextT.move(to: CGPoint(x: 200, y: 0))
            contextT.addLine(to: CGPoint(x: 200, y: 50))
            
            // N Letter
            contextT.move(to: CGPoint(x: 225, y: 50))
            contextT.addLine(to: CGPoint(x: 225, y: 0))
            contextT.addLine(to: CGPoint(x: 270, y: 50))
            contextT.addLine(to: CGPoint(x: 270, y: 0))
            
            contextT.setStrokeColor(UIColor.black.cgColor)
            contextT.strokePath()
        }
        
        imageView.image = img
    }
    

}


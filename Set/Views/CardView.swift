//
//  CardView.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 24/07/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    let card: Card
    
    override var frame: CGRect {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    //  MARK: - Symdol drawing.
    
    private func drawASymbol(in bounds: CGRect, setColorViewPreferencesFotThatSymbol: (UIBezierPath) -> Void) {
        let context: UIBezierPath
        switch card.symbol {
        case .diamond:
            context = UIBezierPath()
            context.move(to: CGPoint(x: bounds.midX, y: bounds.midY - bounds.maxX * 0.25)) // 1
            context.addLine(to: CGPoint(x: bounds.midX - bounds.maxX * 0.4, y: bounds.midY)) // 2
            context.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY + bounds.maxX * 0.25)) // 3
            context.addLine(to: CGPoint(x: bounds.midX + bounds.maxX * 0.4, y: bounds.midY)) // 4
            context.close()
            
        case .oval:
            context = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: bounds.midX - bounds.maxX * 0.4, y: bounds.midY - bounds.maxX * 0.25), size: CGSize(width: bounds.maxX * 0.8, height: bounds.maxX * 0.5)))
            
        case .squiggle:
            context = UIBezierPath(rect: CGRect(origin: CGPoint(x: bounds.midX - bounds.maxX * 0.4, y: bounds.midY - bounds.maxX * 0.25), size: CGSize(width: bounds.maxX * 0.8, height: bounds.maxX * 0.5)))
            
        }
        context.lineWidth = borderSize
        context.addClip()
        setColorViewPreferencesFotThatSymbol(context)
    }
    //  MARK: - Number drawing.
    private func getScaledFont() -> UIFont {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(cornerFontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        return font
    }
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.font = getScaledFont()
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel) {
        label.font = getScaledFont()
        label.text = String(card.number)
        label.frame.size = CGSize.zero
        label.sizeToFit()
    }
    
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureCornerLabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        configureCornerLabel(lowerRightCornerLabel)
        lowerRightCornerLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
    }
  
    // MARK: - Color and shadings
    
    func getColorForCard() -> UIColor {
        switch card.color {
        case .green:
            return UIColor.green
        case .red:
            return UIColor.red
        case .purple:
            return UIColor.purple
        }
    }
    
    func setShadingsForCard(context: UIBezierPath) {
        let color = getColorForCard()
        switch card.shading {
        case .open:
            color.setStroke()
            context.stroke()
        case .solid:
            color.setFill()
            context.fill()
        case .striped:
            color.setStroke()
            context.stroke()
            for x in stride(from: 0, to: bounds.width, by: bounds.width / 20) {
                let path = UIBezierPath()
                path.move(to: CGPoint(x: x, y: bounds.origin.y))
                path.addLine(to: CGPoint(x: x, y: bounds.maxY))
                path.stroke()
            }
        }
    }
    
    //MARK: - Recognize State changes.
    
    enum State {
        case selected
        case unselected
    }
    
    var state: State {
        didSet {
            stateChangesRecognizer()
        }
    }
    
    func stateChangesRecognizer() {
        layer.cornerRadius = cornerRadius
        switch state {
        case .selected:
            layer.borderWidth = cornerOffset
            layer.borderColor = UIColor.red.cgColor
        
        case .unselected:
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
    //MARK: - Draw() and Initialization.
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        drawASymbol(in: roundedRect.bounds, setColorViewPreferencesFotThatSymbol: setShadingsForCard)
        
        stateChangesRecognizer()
        
    }
    
    init(frame: CGRect = CGRect.zero, card: Card) {
        self.card = card
        self.state = .unselected
//        self.addGe
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection:  UITraitCollection?) { // About ediditing text size and after this changes update our ViewCard.
        
        setNeedsDisplay()
        setNeedsLayout()
    }
}

extension CardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.2
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
        static let borderSizeToBoundsSize: CGFloat = 500
    }
    private var borderSize: CGFloat {
        return SizeRatio.borderSizeToBoundsSize / bounds.size.height
    }
    private var cornerRadius: CGFloat { // cornerRadius is proportional to the bounds
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat { // offset from rounding
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat { // bigger bounds require bigger font size
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}

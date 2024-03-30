import UIKit

extension UIView {
    
    
    @IBInspectable var bottomCurve: Double {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
    
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    
    @IBInspectable
    var CornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    
    
    func addTopShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.3
        clipsToBounds = false
    }
    
    @IBInspectable var topCurve: Double {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
    
    
    
    @IBInspectable var hasBasicShadow: Bool {
        get {
            return self.hasBasicShadow
        }
        
        set {
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOffset = .zero
            layer.shadowOpacity = 0.3
            clipsToBounds = false
        }
    }
    
    
    
    
}


extension UIView {
    func addActiveBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(resource: .border).cgColor
    }
    func addInactiveBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(resource: .border).cgColor
    }
}

extension UIView {
    func addCorner(_ radius: CGFloat = 8) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

extension UIView {
    func addUpperCorners(_ radius: CGFloat = 8){
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
    }
}


//extension UIView {
//    var parentViewController: UIViewController? {
//        var parentResponder: UIResponder? = self
//        while let responder = parentResponder {
//            if let viewController = responder as? UIViewController {
//                return viewController
//            }
//            parentResponder = responder.next
//        }
//        return nil
//    }
//}

extension UIView {
    func addTapGesture(handler: @escaping () -> Void) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        
        // Store the closure in an associated object
        objc_setAssociatedObject(self, AssociatedKeys.tapHandler, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        if let tapHandler = objc_getAssociatedObject(self, AssociatedKeys.tapHandler) as? () -> Void {
            tapHandler()
        }
    }
}

private struct AssociatedKeys {
    static var tapHandler = "tapHandler"
}


class CircleView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}

class BorderView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addCorner()
        self.layer.borderColor = UIColor(resource: .border).cgColor
        self.layer.borderWidth = 1.5
    }
}

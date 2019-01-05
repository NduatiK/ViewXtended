import UIKit

public class KeyboardLayoutConstraint: NSLayoutConstraint {

    /// A value that stores the constant at the time of initialization. Lazy so as to not access constant prematurely
    lazy var originalConstant = constant
    /// The current height of the keyboard, 0 if hidden
    open var keyboardVisibleHeight: CGFloat = 0

    var keyBoardMaxHeight: CGFloat = 0

    /// An additional offset experienced when the keyboard is visible
    /// If positive, the first item is pushed even further up
    @IBInspectable open var customInset: CGFloat = 0

    override public init() {
        super.init()
        setup()
    }

    func setup() {

        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Notification

    @objc func keyboardWillShowNotification(_ notification: Foundation.Notification) {
        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let frame = frameValue.cgRectValue
                keyBoardMaxHeight = frame.size.height
                keyboardVisibleHeight = frame.size.height + customInset
            }

            self.updateConstant()
            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
                let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {
                let options = UIViewAnimationOptions(rawValue: curve.uintValue)

                UIView.animate(
                    withDuration: TimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        UIApplication.shared.keyWindow?.layoutIfNeeded()
                        return
                })
            }
        }
    }

    @objc func keyboardWillHideNotification(_ notification: Foundation.Notification) {

        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
                let frame = frameValue.cgRectValue
                keyboardVisibleHeight = frame.size.height + customInset
            }
            self.updateConstant()

            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
                let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {


                let options = UIViewAnimationOptions(rawValue: curve.uintValue)

                UIView.animate(
                    withDuration: TimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        UIApplication.shared.keyWindow?.layoutIfNeeded()
                        return
                })
            }
        }
    }

    open func updateConstant() {
        self.constant = originalConstant + keyboardVisibleHeight
    }
}

public class KeyboardLayoutConstraintX: KeyboardLayoutConstraint {

    @IBInspectable open var inverted: Bool = false

    override public func updateConstant() {
        if inverted {
            self.constant = originalConstant - keyboardVisibleHeight
        } else {
            self.constant = originalConstant + keyboardVisibleHeight
        }
    }
}

import UIKit

public class KeyboardLayoutConstraint: NSLayoutConstraint {

    open var offset: CGFloat = 0
    open var keyboardVisibleHeight: CGFloat = 0

    override open func awakeFromNib() {
        super.awakeFromNib()

        offset = constant

        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardLayoutConstraint.keyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Notification

    @objc func keyboardWillShowNotification(_ notification: Foundation.Notification) {
        if let userInfo = notification.userInfo {
            if let frameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let frame = frameValue.cgRectValue
                keyboardVisibleHeight = frame.size.height
            }

            self.updateConstant()
            switch (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber, userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):

                let options = UIViewAnimationOptions(rawValue: curve.uintValue)

                UIView.animate(
                    withDuration: TimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        UIApplication.shared.keyWindow?.layoutIfNeeded()
                        return
                })
            default:

                break
            }

        }

    }

    @objc func keyboardWillHideNotification(_ notification: Foundation.Notification) {
        keyboardVisibleHeight = 0
        self.updateConstant()

        if let userInfo = notification.userInfo {

            switch (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
                    userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) {
            case let (.some(duration), .some(curve)):

                let options = UIViewAnimationOptions(rawValue: curve.uintValue)

                UIView.animate(
                    withDuration: TimeInterval(duration.doubleValue),
                    delay: 0,
                    options: options,
                    animations: {
                        UIApplication.shared.keyWindow?.layoutIfNeeded()
                        return
                })
            default:
                break
            }
        }
    }

    @IBInspectable customInset: CGFloat = 0

    open func updateConstant() {
        self.constant = offset + keyboardVisibleHeight - customInset
    }
}

// Make KeyboardLayoutConstraint open
public class KeyboardLayoutConstraintX: KeyboardLayoutConstraint {

    @IBInspectable open var inverted: Bool = false

    // make KeyboardLayoutConstraint.updateConstant open
    // make offset open
    // make keyboardVisibleHeight open

    override public func updateConstant() {
        if inverted {
            self.constant = offset - keyboardVisibleHeight
        } else {
            self.constant = offset + keyboardVisibleHeight
        }
    }
}

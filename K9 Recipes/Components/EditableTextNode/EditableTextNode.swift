//
//  EditableTextNode.swift
//  K9 Recipes
//
//  Created by Orkhan Huseynov on 9/8/19.
//  Copyright © 2019 Orkhan Huseynov. All rights reserved.
//

import AsyncDisplayKit

extension CGFloat {
    public static let editableTextNodeHeight: CGFloat = 52.0
    public static let cornerRadius: CGFloat = 4.0
}

extension UIEdgeInsets {
    public static let textFieldInsets = UIEdgeInsets(
        top: (CGFloat.editableTextNodeHeight - UIFont.systemFont(ofSize: 17).lineHeight)/2,
        left: 14.0,
        bottom: 0,
        right: 14.0
    )
}

class EditableTextNode: ASEditableTextNode {
    
    var textInsets: UIEdgeInsets = .textFieldInsets {
        didSet {
            textContainerInset = textInsets
        }
    }
    
    var font: UIFont?
    var onChange: ((String?) -> Void)?
    
    var text: String? {
        get {
            return attributedText?.string
        }
        set(val) {
            attributedText = NSAttributedString(
                string: val ?? "",
                attributes: [
                    .font: font ?? .systemFont(ofSize: 17),
                    .foregroundColor: color ?? .baseBlack
                ]
            )
        }
    }
    
    var placeholder: String? {
        get {
            return attributedPlaceholderText?.string
        }
        set(val) {
            attributedPlaceholderText = NSAttributedString(
                string: val ?? "",
                attributes: [
                    .font: font ?? .systemFont(ofSize: 17),
                    .foregroundColor: UIColor.baseLightGray
                ]
            )
        }
    }
    
    var isEnabled = true {
        willSet(val) {
            isUserInteractionEnabled = val
            backgroundColor = isUserInteractionEnabled ? .white : UIColor.baseWhite
        }
    }
    
    var isFilled: Bool {
        return !(text?.isEmpty ?? true)
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: text ?? "")
    }
    
    var color: UIColor? {
        get {
            return attributedText?.attributes(at: 0, effectiveRange: .none)[NSAttributedString.Key.foregroundColor] as? UIColor
        }
        set(val) {
            attributedText = NSAttributedString(
                string: attributedText?.string ?? "",
                attributes: [
                    .foregroundColor: val ?? .baseBlack,
                    .font: font ?? .systemFont(ofSize: 17)
                ]
            )
        }
    }
    
    override init() {
        super.init()
        
        borderWidth = 1
        borderColor = UIColor.baseGreen.cgColor
        backgroundColor = .clear
        returnKeyType = .done
        cornerRadius = .cornerRadius
        font = .systemFont(ofSize: 17)
        style.preferredSize.height = .editableTextNodeHeight
        textContainerInset = .textFieldInsets
        typingAttributes = [
            NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 17)
        ] as [String: Any]
        
        delegate = self
    }
    
    override init(textKitComponents: ASTextKitComponents, placeholderTextKitComponents: ASTextKitComponents) {
        super.init(textKitComponents: textKitComponents, placeholderTextKitComponents: placeholderTextKitComponents)
    }
    
    override func didLoad() {
        super.didLoad()
        
        textView.textContainer.lineBreakMode = .byTruncatingTail
    }
    
}

extension EditableTextNode: ASEditableTextNodeDelegate {
    
    func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) {
        onChange?((editableTextNode as? EditableTextNode)?.text)
    }
    
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            editableTextNode.resignFirstResponder()
            return false
        }
        
        return true
    }
    
}


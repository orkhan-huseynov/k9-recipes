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
    
    var autocompletionStrings: [String] = [] {
        didSet {
            autocorrectionType = .no
        }
    }
    
    var autoCompleteCharacterCount = 0
    var timer = Timer()
    
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(resetFormatting),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension EditableTextNode: ASEditableTextNodeDelegate {
    
    func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) {
        onChange?((editableTextNode as? EditableTextNode)?.text)
    }
    
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            editableTextNode.resignFirstResponder()
            resetFormatting()
            return false
        }
        
        var subString = (editableTextNode.textView.text.capitalized as NSString).replacingCharacters(in: range, with: text)
        subString = formatSubstring(subString: subString)
        
        if subString.isEmpty {
            resetValues()
        } else {
            searchEntriesWith(substring: subString)
        }
        
        return true
    }
    
    func formatSubstring(subString: String) -> String {
        return String(subString.dropLast(autoCompleteCharacterCount)).lowercased().capitalized
    }
    
    func resetValues() {
        autoCompleteCharacterCount = 0
        text = ""
    }
    
    func searchEntriesWith(substring: String) {
        let userQuery = substring
        let suggestions = getAutocompleteSuggestions(userText: substring)
        
        if suggestions.count > 0 {
            timer = .scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { [weak self] timer in
                if let autocompleteResult = self?.formatResult(substring: substring, possibleMatches: suggestions) {
                    self?.insertFormattedText(autocompleteResult: autocompleteResult, userQuery: userQuery)
                    self?.moveCaretToEnd(userQuery: userQuery)
                }
            })
        } else {
            timer = .scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { [weak self] timer in
                self?.text = substring
            })
            autoCompleteCharacterCount = 0
        }
    }
    
    func getAutocompleteSuggestions(userText: String) -> [String]{
        return autocompletionStrings.compactMap { $0.starts(with: userText) ? $0 : nil }
    }
    
    func insertFormattedText(autocompleteResult: String, userQuery : String) {
        let finalString = userQuery + autocompleteResult
        
        let range = NSRange(location: userQuery.count, length: autocompleteResult.count)
        let totalRange = NSRange(location: 0, length: finalString.count)
        
        let formattedString = NSMutableAttributedString(string: finalString)
        
        formattedString.addAttribute(.foregroundColor, value: UIColor.baseGray, range: range)
        formattedString.addAttribute(.font, value: font ?? UIFont.systemFont(ofSize: 17), range: totalRange)
        
        attributedText = formattedString
    }
    
    func moveCaretToEnd(userQuery: String) {
        if let newPosition = textView.position(from: textView.beginningOfDocument, offset: userQuery.count) {
            textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
        }
        if let start = textView.selectedTextRange?.start {
            textView.offset(from: textView.beginningOfDocument, to: start)
        }
    }
    
    func formatResult(substring: String, possibleMatches: [String]) -> String {
        guard var autoCompleteResult = possibleMatches.first else { return "" }
        autoCompleteResult.removeSubrange(
            autoCompleteResult.startIndex..<autoCompleteResult.index(autoCompleteResult.startIndex, offsetBy: substring.count)
        )
        autoCompleteCharacterCount = autoCompleteResult.count
        return autoCompleteResult
    }
    
    @objc func resetFormatting() {
        color = .baseBlack
        textView.text = text
        autoCompleteCharacterCount = 0
    }
}


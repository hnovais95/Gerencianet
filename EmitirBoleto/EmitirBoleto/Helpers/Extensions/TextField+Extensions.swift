//
//  BindingTextField.swift
//  EmitirBoleto
//
//  Created by Heitor Novais | Gerencianet on 26/05/21.
//

import Foundation
import UIKit

private class WeakHolder<T: AnyObject>: Hashable {
    
    weak var object: T?
    let hash: Int

    init(object: T) {
        self.object = object
        hash = ObjectIdentifier(object).hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(hash)
    }

    static func ==(lhs: WeakHolder, rhs: WeakHolder) -> Bool {
        return lhs.hash == rhs.hash
    }
}

class WeakDictionary<T1: AnyObject, T2> {
    
    private var dictionary = [WeakHolder<T1>: T2]()

    func set(forKey: T1, object: T2?) {
        dictionary[WeakHolder(object: forKey)] = object
    }

    func get(forKey: T1) -> T2? {
        let obj = dictionary[WeakHolder(object: forKey)]
        return obj
    }

    func forEach(_ handler: ((key: T1, value: T2)) -> Void) {
        dictionary.forEach {
            if let object = $0.key.object, let value = dictionary[$0.key] {
                handler((object, value))
            }
        }
    }
    
    func clean() {
        var removeList = [WeakHolder<T1>]()
        dictionary.forEach {
            if $0.key.object == nil {
                removeList.append($0.key)
            }
        }
        removeList.forEach {
            dictionary[$0] = nil
        }
    }
}

extension UITextField {
    
    private static var storedCallbackTextEditingChanged = WeakDictionary<UITextField, ((String) -> Void)?>()
    
    var textEdited: ((String) -> Void)? {
        get {
            return UITextField.storedCallbackTextEditingChanged.get(forKey: self) ?? nil
        }
        set {
            UITextField.storedCallbackTextEditingChanged.set(forKey: self, object: newValue)
        }
    }
    
    func bind(completion: @escaping (String) -> Void) {
        textEdited = completion
        addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textEdited?(text)
    }
    
    static func clearStoredCallbacksTextEditingChanged() {
        UITextField.storedCallbackTextEditingChanged.clean()
    }
}

extension UITextField {
    
    func replace(withText text: String) {
        self.text = ""
        self.insertText(text)
    }
}


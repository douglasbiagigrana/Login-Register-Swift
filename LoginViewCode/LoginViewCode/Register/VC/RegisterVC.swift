//
//  RegisterVC.swift
//  LoginViewCode
//
//  Created by Douglas Biagi Grana on 26/09/21.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    var registerScreen:RegisterScreen?
    
    var auth:Auth?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configTextFieldDelegate(delegate: self)
        self.registerScreen?.delegate(delegate: self)
        self.auth = Auth.auth()
    }
    
}

extension RegisterVC:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.validaTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension RegisterVC:RegisterScreenProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton() {
        guard let register = self.registerScreen else {return}
        
        self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { Result, Error in
            if Error != nil {
                print("Error ao cadastrar")
            } else {
                print("Sucesso ao cadastrar")
            }
        })
    }
}

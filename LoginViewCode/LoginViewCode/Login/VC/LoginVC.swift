//
//  ViewController.swift
//  LoginViewCode
//
//  Created by Douglas Biagi Grana on 24/09/21.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    var loginScreen:LoginScreen?
    
    var auth:Auth?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.delegate(delegate: self)
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.auth = Auth.auth()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

extension LoginVC:LoginScreenProtocol {
    func actionLoginButton() {
        guard let login = self.loginScreen else {return}
        
        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { usuario, error in
            
            if error != nil {
                print("Dados Incorretos")
            } else {
                if usuario == nil {
                    print("Tivemos um problema inesperado, tente novamente mais tarde")
                } else {
                    print("Parabens, usuario logado com sucesso")
                }
            }
        })
    }
    
    func actionRegisterButton() {
        let vc:RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginVC:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.validaTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


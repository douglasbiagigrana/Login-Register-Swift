//
//  LoginScreen.swift
//  LoginViewCode
//
//  Created by Douglas Biagi Grana on 24/09/21.
//

import UIKit

protocol LoginScreenProtocol:AnyObject {
    func actionLoginButton()
    func actionRegisterButton()
}

class LoginScreen: UIView {
    
    private weak var delegate:LoginScreenProtocol?
    
    func delegate(delegate:LoginScreenProtocol?) {
        self.delegate = delegate
    }

    //MARK: UI ELEMENTS
    lazy var loginLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "Login"
        
        return label
    }()
    
    lazy var logoAppImageView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var emailTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu Email"
        tf.textColor = .darkGray
        
        return tf
    }()
    
    lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.isSecureTextEntry = true
        tf.placeholder = "Digite sua Senha"
        tf.textColor = .darkGray
        
        return tf
    }()
    
    lazy var loginButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedLoginButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var registerButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Não tem conta? Cadastre-se aqui", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        
        self.configLoginLabelConstrainst()
        self.configLogoAppImageViewConstrainst()
        self.configEmailTextFieldConstrainst()
        self.configPasswordTextFieldConstrainst()
        self.configLoginButtonConstrainst()
        self.configRegisterButtonConstrainst()
        
        self.configButtonEnable(enable: false)
    }
    
    private func configBackGround() {
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
    }
    
    private func configSuperView() {
        self.addSubview(self.loginLabel)
        self.addSubview(self.logoAppImageView)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.loginButton)
        self.addSubview(self.registerButton)
    }
    
    public func configTextFieldDelegate(delegate:UITextFieldDelegate) {
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
    @objc private func tappedLoginButton() {
        self.delegate?.actionLoginButton()
    }
    
    @objc private func tappedRegisterButton() {
        self.delegate?.actionRegisterButton()
    }
    
    public func validaTextFields() {
        let email:String = self.emailTextField.text ?? ""
        let password:String = self.passwordTextField.text ?? ""
        
        if !email.isEmpty && !password.isEmpty {
            self.configButtonEnable(enable: true)
        } else {
            self.configButtonEnable(enable: false)
        }
    }
    
    private func configButtonEnable(enable:Bool) {
        if enable {
            self.loginButton.setTitleColor(.white, for: .normal)
            self.loginButton.isEnabled = true
        } else {
            self.loginButton.setTitleColor(.lightGray, for: .normal)
            self.loginButton.isEnabled = false
        }
    }
    
    public func getEmail()-> String {
        return self.emailTextField.text ?? ""
    }
    
    public func getPassword()-> String {
        return self.passwordTextField.text ?? ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: CONSTRAINTS
    //MANEIRA DE CONSTRAINTS NATIVA
    //equal to: -> basear em um determinado elemento
    //constant -> afastar ou aproximar do elemento referente(equalto)
    //equalToConstant -> setar um valor fixo para um determinado elemento
    
    //MANEIRA COM FRAMEWORK SNAPKIT
    //offset = valor positivo
    //inset = valor negativo
    func configLoginLabelConstrainst() {
        self.loginLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func configLogoAppImageViewConstrainst() {
        self.logoAppImageView.snp.makeConstraints { make in
            make.top.equalTo(self.loginLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(60)
            make.height.equalTo(150)
        }
    }
    
    func configEmailTextFieldConstrainst() {
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.logoAppImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    func configPasswordTextFieldConstrainst() {
        self.passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField.snp.bottom).offset(15)
            make.leading.equalTo(self.emailTextField.snp.leading)
            make.trailing.equalTo(self.emailTextField.snp.trailing)
            make.height.equalTo(self.emailTextField.snp.height)
        }
    }
    
    func configLoginButtonConstrainst() {
        self.loginButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
            make.leading.equalTo(self.emailTextField.snp.leading)
            make.trailing.equalTo(self.emailTextField.snp.trailing)
            make.height.equalTo(self.emailTextField.snp.height)
        }
    }
    
    func configRegisterButtonConstrainst() {
        self.registerButton.snp.makeConstraints { make in
            make.top.equalTo(self.loginButton.snp.bottom).offset(15)
            make.leading.equalTo(self.emailTextField.snp.leading)
            make.trailing.equalTo(self.emailTextField.snp.trailing)
            make.height.equalTo(self.emailTextField.snp.height)
        }
    }
    

}

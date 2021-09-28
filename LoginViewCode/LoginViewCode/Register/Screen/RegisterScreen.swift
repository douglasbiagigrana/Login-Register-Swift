//
//  RegisterScreen.swift
//  LoginViewCode
//
//  Created by Douglas Biagi Grana on 26/09/21.
//

import UIKit

protocol RegisterScreenProtocol:AnyObject {
    func actionBackButton()
    func actionRegisterButton()
}

class RegisterScreen: UIView {
    
    weak private var delegate:RegisterScreenProtocol?
    
    func delegate(delegate:RegisterScreenProtocol?) {
        self.delegate = delegate
    }
    
    //MARK: UI ELEMENTS
    lazy var registerLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "Register"
        
        return label
    }()
    
    lazy var backButton:UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var imageAddUser:UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "register")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var emailTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu Email"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf
    }()
    
    lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.isSecureTextEntry = true
        tf.placeholder = "Digite sua Senha"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf
    }()
    
    lazy var registerButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        
        self.configRegisterLabelConstrainst()
        self.configBackButtonConstrainst()
        self.configImageAddUserConstrainst()
        self.configEmailTextFieldConstrainst()
        self.configPasswordTextFieldConstrainst()
        self.configRegisterButtonConstrainst()
        
        self.configButtonEnable(enable: false)
    }
    
    private func configBackGround() {
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
    }
    
    public func configTextFieldDelegate(delegate:UITextFieldDelegate) {
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
    @objc private func tappedBackButton() {
        self.delegate?.actionBackButton()
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
            self.registerButton.setTitleColor(.white, for: .normal)
            self.registerButton.isEnabled = true
        } else {
            self.registerButton.setTitleColor(.lightGray, for: .normal)
            self.registerButton.isEnabled = false
        }
    }
    
    public func getEmail()-> String {
        return self.emailTextField.text ?? ""
    }
    
    public func getPassword()-> String {
        return self.passwordTextField.text ?? ""
    }
    
    private func configSuperView() {
        self.addSubview(self.registerLabel)
        self.addSubview(self.backButton)
        self.addSubview(self.imageAddUser)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.registerButton)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: CONSTRAINTS
    func configRegisterLabelConstrainst() {
        self.registerLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func configBackButtonConstrainst() {
        self.backButton.snp.makeConstraints { make in
            make.top.equalTo(self.registerLabel.snp.top)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    func configImageAddUserConstrainst() {
        self.imageAddUser.snp.makeConstraints { make in
            make.top.equalTo(self.registerLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(60)
            make.height.equalTo(150)
        }
    }
    
    func configEmailTextFieldConstrainst() {
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.imageAddUser.snp.bottom).offset(20)
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
    
    func configRegisterButtonConstrainst() {
        self.registerButton.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(15)
            make.leading.equalTo(self.emailTextField.snp.leading)
            make.trailing.equalTo(self.emailTextField.snp.trailing)
            make.height.equalTo(self.emailTextField.snp.height)
        }
    }
    
    
}

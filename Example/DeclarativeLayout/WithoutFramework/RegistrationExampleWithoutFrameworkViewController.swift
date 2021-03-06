import UIKit

class RegistrationWithoutFrameworkViewController: UIViewController {
    
    private let registerOrSignInSegmentedControl = UISegmentedControl()
    private let headerLabel = UILabel()
    private let stackView = UIStackView()
    private let emailContainerView = UIView()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordContainerView = UIView()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let submitButton = UIButton()
    private let forgotMyPasswordButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "No Framework"
        layoutAllViews()
        configureAllViews()
    }
    
    private func layoutAllViews () {
        layoutViewHierarchy()
        layoutHeaderLabel()
        layoutStackView()
        layoutEmailContainerView()
        layoutPasswordContainerView()
        layoutSubmitButton()
        layoutForgotMyPasswordButton()
    }
    
    private func layoutViewHierarchy() {
        registerOrSignInSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        forgotMyPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(registerOrSignInSegmentedControl)
        stackView.addArrangedSubview(headerLabel)
        
        emailContainerView.addSubview(emailLabel)
        emailContainerView.addSubview(emailTextField)
        stackView.addArrangedSubview(emailContainerView)
        
        passwordContainerView.addSubview(passwordLabel)
        passwordContainerView.addSubview(passwordTextField)
        stackView.addArrangedSubview(passwordContainerView)
        
        stackView.addArrangedSubview(submitButton)
        view.addSubview(stackView)
        view.addSubview(forgotMyPasswordButton)
    }
    
    private func layoutStackView() {
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func layoutHeaderLabel() {
        stackView.setCustomSpacing(30, after: registerOrSignInSegmentedControl)
    }
    
    private func layoutEmailContainerView() {
        stackView.setCustomSpacing(20, after: headerLabel)
        layoutEmailLabel()
        layoutEmailTextField()
    }
    
    private func layoutEmailLabel() {
        emailLabel.topAnchor.constraint(greaterThanOrEqualTo: emailContainerView.topAnchor).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: emailContainerView.leadingAnchor).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: -20).isActive = true
        emailLabel.bottomAnchor.constraint(lessThanOrEqualTo: emailContainerView.bottomAnchor).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor)
    }
    
    private func layoutEmailTextField() {
        emailTextField.topAnchor.constraint(greaterThanOrEqualTo: emailContainerView.topAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: emailContainerView.trailingAnchor).isActive = true
        emailTextField.bottomAnchor.constraint(greaterThanOrEqualTo: emailContainerView.bottomAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor).isActive = true
    }
    
    private func layoutPasswordContainerView() {
        stackView.setCustomSpacing(40, after: emailContainerView)
        layoutPasswordLabel()
        layoutPasswordTextField()
    }
    
    private func layoutPasswordLabel() {
        passwordLabel.topAnchor.constraint(greaterThanOrEqualTo: passwordContainerView.topAnchor).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: -20).isActive = true
        passwordLabel.bottomAnchor.constraint(lessThanOrEqualTo: passwordContainerView.bottomAnchor).isActive = true
        passwordLabel.centerYAnchor.constraint(equalTo: passwordContainerView.centerYAnchor).isActive = true
    }
    
    private func layoutPasswordTextField() {
        passwordTextField.topAnchor.constraint(greaterThanOrEqualTo: passwordContainerView.topAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(greaterThanOrEqualTo: passwordContainerView.bottomAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordContainerView.centerYAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor).isActive = true
    }
    
    private func layoutSubmitButton() {
        stackView.setCustomSpacing(40, after: passwordContainerView)
    }
    
    private func layoutForgotMyPasswordButton() {
        forgotMyPasswordButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        forgotMyPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // Don't worry about this below here
    
    private func configureAllViews() {
        view.backgroundColor = .white
        registerOrSignInSegmentedControl.insertSegment(withTitle: "Register", at: 0, animated: false)
        registerOrSignInSegmentedControl.insertSegment(withTitle: "Sign In", at: 1, animated: false)
        
        if registerOrSignInSegmentedControl.selectedSegmentIndex == -1 {
            registerOrSignInSegmentedControl.selectedSegmentIndex = 0
        }
        
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        if registerOrSignInSegmentedControl.selectedSegmentIndex == 0 {
            headerLabel.text = "Register"
        } else {
            headerLabel.text = "Sign In"
        }
        
        stackView.axis = .vertical
        
        emailLabel.text = "Email"
        emailTextField.placeholder = "example@example.com"
        if #available(iOS 10.0, *) {
            emailTextField.textContentType = .emailAddress
        }
        emailTextField.layer.borderColor = UIColor.blue.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.textAlignment = .center
        emailTextField.isUserInteractionEnabled = false
        
        passwordLabel.text = "Password"
        passwordTextField.placeholder = "secure password here"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderColor = UIColor.blue.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.textAlignment = .center
        passwordTextField.isUserInteractionEnabled = false
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor.blue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.clipsToBounds = true
        submitButton.titleLabel?.textAlignment = .center
        
        forgotMyPasswordButton.setTitle("forgot your password?", for: .normal)
        forgotMyPasswordButton.setTitleColor(.blue, for: .normal)
    }
}

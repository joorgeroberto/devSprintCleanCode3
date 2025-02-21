//
//  CeuContactUsView.swift
//  CleanCodeApp
//
//  Created by Jorge de Carvalho on 18/02/25.
//
import UIKit

class CeuContactUsView: UIView {
    lazy var symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36)

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = CeuContactUsStrings.writeYourMessage.localized()
        return textView
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.text = CeuContactUsStrings.chooseYourContactChannel.localized()
        return titleLabel
    }()

    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.textColor = .black
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        messageLabel.text = CeuContactUsStrings.orSendYourMessage.localized()
        messageLabel.numberOfLines = 2
        messageLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return messageLabel
    }()

    lazy var phoneButton: UIButton = {
        let phoneButton = UIButton()
        phoneButton.backgroundColor = .systemGray4
        phoneButton.layer.cornerRadius = 10
        phoneButton.setImage(UIImage.init(systemName: "phone")?.withConfiguration(symbolConfiguration), for: .normal)
        return phoneButton
    }()

    lazy var emailButton: UIButton = {
        let emailButton = UIButton()
        emailButton.backgroundColor = .systemGray4
        emailButton.layer.cornerRadius = 10
        emailButton.setImage(UIImage.init(systemName: "envelope")?.withConfiguration(symbolConfiguration), for: .normal)
        return emailButton
    }()

    lazy var chatButton: UIButton = {
        let chatButton = UIButton()
        chatButton.backgroundColor = .systemGray4
        chatButton.layer.cornerRadius = 10
        chatButton.setImage(UIImage.init(systemName: "message")?.withConfiguration(symbolConfiguration), for: .normal)
        return chatButton
    }()

    lazy var sendMessageButton: UIButton = {
        let sendMessageButton = UIButton()
        sendMessageButton.backgroundColor = .blue
        sendMessageButton.setTitle(CeuContactUsStrings.send.localized(), for: .normal)
        sendMessageButton.setTitleColor(.white, for: .normal)
        sendMessageButton.layer.cornerRadius = 10
        sendMessageButton.setContentHuggingPriority(.required, for: .horizontal)
        return sendMessageButton
    }()

    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setTitle(CeuContactUsStrings.goBack.localized(), for: .normal)
        closeButton.setTitleColor(.blue, for: .normal)
        closeButton.backgroundColor = .clear
        closeButton.layer.borderWidth = 1
        closeButton.layer.borderColor = UIColor.blue.cgColor
        closeButton.layer.cornerRadius = 10
        return closeButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError(CeuContactUsStrings.initFatalErrorMessage.localized())
    }
}

extension CeuContactUsView {
    // MARK: AddTarget Functions
    func configureEmailButton(target: Any, action: Selector) {
        emailButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func configurePhoneButton(target: Any, action: Selector) {
        phoneButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func configureChatButton(target: Any, action: Selector) {
        chatButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func configureSendMessageButton(target: Any, action: Selector) {
        sendMessageButton.addTarget(target, action: action, for: .touchUpInside)
    }

    func configureCloseButton(target: Any, action: Selector) {
        closeButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension CeuContactUsView {
    // MARK: Setup View Functions
    private func setupViews() {
        self.backgroundColor = .systemGray6
        setupTitleLabel()
        setupPhoneButton()
        setupEmailButton()
        setupChatButton()
        setupMessageLabel()
        setupCloseButton()
        setupSendMessageButton()
        setupTextView()
    }

    private func setupEmailButton() {
        setupSubview(emailButton, constraints: [
            emailButton.centerYAnchor.constraint(equalTo: phoneButton.centerYAnchor),
            emailButton.widthAnchor.constraint(equalToConstant: 80),
            emailButton.heightAnchor.constraint(equalToConstant: 80),
            emailButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }

    private func setupTitleLabel() {
        setupSubview(titleLabel, constraints: [
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    private func setupPhoneButton() {
        setupSubview(phoneButton, constraints: [
            phoneButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            phoneButton.widthAnchor.constraint(equalToConstant: 80),
            phoneButton.heightAnchor.constraint(equalToConstant: 80),
            phoneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }

    private func setupChatButton() {
        setupSubview(chatButton, constraints: [
            chatButton.centerYAnchor.constraint(equalTo: phoneButton.centerYAnchor),
            chatButton.widthAnchor.constraint(equalToConstant: 80),
            chatButton.heightAnchor.constraint(equalToConstant: 80),
            chatButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    private func setupMessageLabel() {
        setupSubview(messageLabel, constraints: [
            messageLabel.topAnchor.constraint(equalTo: phoneButton.bottomAnchor, constant: 30),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    private func setupSendMessageButton() {
        setupSubview(sendMessageButton, constraints: [
            sendMessageButton.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -20),
            sendMessageButton.heightAnchor.constraint(equalToConstant: 40),
            sendMessageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            sendMessageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    private func setupTextView() {
        setupSubview(textView, constraints: [
            textView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: sendMessageButton.topAnchor, constant: -30)
        ])
    }

    private func setupCloseButton() {
        setupSubview(closeButton, constraints: [
            closeButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    private func setupSubview(_ view: UIView, constraints: [NSLayoutConstraint]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate(constraints)
    }
}

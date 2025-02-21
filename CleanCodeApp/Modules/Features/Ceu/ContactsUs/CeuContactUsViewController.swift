//
//  ContactUsViewController.swift
//  DeliveryAppChallenge
//
//  Created by Pedro Menezes on 17/07/22.
//

import UIKit

class CeuContactUsViewController: LoadingInheritageController, CeuContactUsDelegate {
    private let viewModel: CeuContactUsViewModel = .init()
    private let ceuContactUsView = CeuContactUsView()
    private let ceuContactUsCoordinator = CeuContactUsCoordinator()

    override func loadView() {
        self.view = ceuContactUsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        viewModel.fetchContactUsData()

        viewModel.delegate = self
    }

    private func configureButtons() {
        ceuContactUsView.configureEmailButton(target: self, action: #selector(emailClick))
        ceuContactUsView.configureChatButton(target: self, action: #selector(chatClicked))
        ceuContactUsView.configurePhoneButton(target: self, action: #selector(phoneClick))
        ceuContactUsView.configureSendMessageButton(target: self, action: #selector(sendMessageButtonAction))
        ceuContactUsView.configureCloseButton(target: self, action: #selector(close))
    }

    @objc
    func phoneClick() {
        let tel = viewModel.model?.phone
        ceuContactUsCoordinator.phoneClick(tel: tel)
    }
    
    @objc
    func emailClick() {
        let mail = viewModel.model?.mail
        ceuContactUsCoordinator.emailClick(mail: mail)
    }

    @objc
    func chatClicked() throws {
        let urls = try viewModel.setupURLs()
        ceuContactUsCoordinator.chatClicked(urls: urls)
    }

    @objc
    func close() {
        dismiss(animated: true)
    }

    @objc
    func sendMessageButtonAction() {
        view.endEditing(true)
        let isTextViewFilled = ceuContactUsView.textView.text.count > 0
        guard let message = ceuContactUsView.textView.text, isTextViewFilled else {
            return
        }
        showLoadingView()
        viewModel.sendMessageRequest(message: message)
    }

    func showSuccessAlertMessage() {
        ceuContactUsCoordinator.showSuccessAlertMessage()
    }

    func showErrorAlertMessage() {
        ceuContactUsCoordinator.showErrorAlertMessage()
    }
}


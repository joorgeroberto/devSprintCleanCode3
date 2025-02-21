//
//  ContactUsViewController.swift
//  DeliveryAppChallenge
//
//  Created by Pedro Menezes on 17/07/22.
//

import UIKit

class CeuContactUsViewController: LoadingInheritageController, CeuContactUsDelegate {
    private let ceuContactUsView = CeuContactUsView()

    private var viewModel: CeuContactUsViewModelProtocol
    private let coordinator: CeuContactUsCoordinatorProtocol

    override func loadView() {
        self.view = ceuContactUsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        viewModel.fetchContactUsData()

        viewModel.delegate = self
    }

    init(viewModel: CeuContactUsViewModelProtocol = CeuContactUsViewModel(), coordinator: CeuContactUsCoordinatorProtocol = CeuContactUsCoordinator()) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        coordinator.phoneClick(tel: tel)
    }
    
    @objc
    func emailClick() {
        let mail = viewModel.model?.mail
        coordinator.emailClick(mail: mail)
    }

    @objc
    func chatClicked() throws {
        let urls = try viewModel.setupURLs()
        coordinator.chatClicked(urls: urls)
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
        coordinator.showSuccessAlertMessage()
    }

    func showErrorAlertMessage() {
        coordinator.showErrorAlertMessage()
    }
}


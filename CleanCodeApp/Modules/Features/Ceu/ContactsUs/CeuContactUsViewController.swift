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
        handleClick(string: tel, urlString: "tel://")
    }
    
    @objc
    func emailClick() {
        let mail = viewModel.model?.mail
        handleClick(string: mail, urlString: "mailto:")
    }

    private func handleClick(string: String?, urlString: String) {
        if let string = string,
           let url = URL(string: urlString + string) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc
    func chatClicked() throws {
        let urls = try viewModel.setupURLs()
        let canOpenWhatsappURL = UIApplication.shared.canOpenURL(urls.whatsappURL)
        if canOpenWhatsappURL {
            openURL(url: urls.whatsappURL)
        } else {
            openURL(url: urls.appleStoreURL)
        }

    }

    private func openURL(url: URL?) {
        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc
    func close() {
        dismiss(animated: true)
    }

    func showErrorAlertMessage() {
        Globals.alertMessage(title: "Ops..", message: "Ocorreu algum erro", targetVC: self) {
            self.dismiss(animated: true)
        }
    }

    func showSuccessAlertMessage() {
        Globals.alertMessage(title: "Sucesso..", message: "Sua mensagem foi enviada", targetVC: self) {
            self.dismiss(animated: true)
        }
    }

    @objc
    func sendMessageButtonAction() {
        view.endEditing(true)
        guard let message = ceuContactUsView.textView.text, ceuContactUsView.textView.text.count > 0 else {
            return
        }
        showLoadingView()
        viewModel.sendMessageRequest(message: message)
    }
}


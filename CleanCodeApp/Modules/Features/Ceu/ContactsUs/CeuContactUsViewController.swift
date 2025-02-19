//
//  ContactUsViewController.swift
//  DeliveryAppChallenge
//
//  Created by Pedro Menezes on 17/07/22.
//

import UIKit

class CeuContactUsViewController: LoadingInheritageController {
    var model: ContactUsModel?
    private let ceuContactUsView = CeuContactUsView()

    override func loadView() {
        self.view = ceuContactUsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        fetchContactUsData()
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
        let tel = model?.phone
        handleClick(string: tel, urlString: "tel://")
    }
    
    @objc
    func emailClick() {
        let mail = model?.mail
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
        let urls = try setupURLs()
        let canOpenWhatsappURL = UIApplication.shared.canOpenURL(urls.whatsappURL)
        if canOpenWhatsappURL {
            openURL(url: urls.whatsappURL)
        } else {
            openURL(url: urls.appleStoreURL)
        }

    }

    private func setupURLs() throws -> CeuUrlTypes {
        let phoneNumber = model?.phone
        guard let phoneNumber = phoneNumber else {
            throw CeuContactUsCommonsErrors.invalidPhoneNumber
        }
        guard let whatsappURL = URL(string: "whatsapp://send?phone=\(phoneNumber)&text=Oi)") else {
            throw CeuContactUsCommonsErrors.invalidURL
        }
        guard let appleStoreURL = URL(string: "https://apps.apple.com/app/whatsapp-messenger/id310633997") else {
            throw CeuContactUsCommonsErrors.invalidURL
        }
        return CeuUrlTypes(appleStoreURL: appleStoreURL, whatsappURL: whatsappURL)
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

    private func fetchContactUsData() {
        showLoadingView()
        let url = Endpoints.contactUs
        AF.shared.request(url, method: .get, parameters: nil, headers: nil) { result in
            self.removeLoadingView()
            switch result {
            case .success(let data):
                self.handleFetchContactUsDataResquestSuccess(data)
            case .failure(let error):
                self.showErrorAlertMessage()
            }
        }
    }

    private func handleFetchContactUsDataResquestSuccess(_ data: Data) {
        let decoder = JSONDecoder()
        if let returned = try? decoder.decode(ContactUsModel.self, from: data) {
            self.model = returned
        } else {
            self.showErrorAlertMessage()
        }
    }

    private func showErrorAlertMessage() {
        Globals.alertMessage(title: "Ops..", message: "Ocorreu algum erro", targetVC: self) {
            self.dismiss(animated: true)
        }
    }

    private func showSuccessAlertMessage() {
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
        sendMessageRequest(message: message)
    }

    func sendMessageRequest(message: String) {
        let parameters = setupParameters(message: message)
        let url = Endpoints.sendMessage
        AF.shared.request(url, method: .post, parameters: parameters, headers: nil) { result in
            self.removeLoadingView()
            switch result {
            case .success:
                self.showSuccessAlertMessage()
            case .failure:
                self.showErrorAlertMessage()
            }
        }
    }

    private func setupParameters(message: String) -> [String: String] {
        let email = model?.mail ?? ""
        let parameters: [String: String] = [
            "email": email,
            "mensagem": message
        ]
        return parameters
    }
}

enum CeuContactUsCommonsErrors: Error {
    case invalidData
    case invalidURL
    case invalidPhoneNumber
}

struct CeuUrlTypes {
    let appleStoreURL: URL
    let whatsappURL: URL
}

//
//  CeuContactUsService.swift
//  CleanCodeApp
//
//  Created by Jorge de Carvalho on 20/02/25.
//
import UIKit

protocol CeuContactUsServiceProtocol {

}

class CeuContactUsService: CeuContactUsServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func sendMessageRequest(model: ContactUsModel?, message: String) {
        let parameters = self.setupParameters(model: model, message: message)
        let url = Endpoints.sendMessage
        AF.shared.request(url, method: .post, parameters: parameters, headers: nil) { result in
            self.delegate?.removeLoadingView()
            switch result {
            case .success:
                self.delegate?.showSuccessAlertMessage()
            case .failure:
                self.delegate?.showErrorAlertMessage()
            }
        }
    }

    func setupParameters(model: ContactUsModel?, message: String) -> [String: String] {
        let email = model?.mail ?? ""
        let parameters: [String: String] = [
            "email": email,
            "mensagem": message
        ]
        return parameters
    }

    func setupURLs(model: ContactUsModel?) throws -> CeuUrlTypes {
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
}

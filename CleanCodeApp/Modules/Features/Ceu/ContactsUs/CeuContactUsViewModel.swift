//
//  CeuContactUsViewModel.swift
//  CleanCodeApp
//
//  Created by Jorge de Carvalho on 18/02/25.
//
import Foundation
import UIKit

enum CeuContactUsCommonsErrors: Error {
    case invalidData
    case invalidURL
    case invalidPhoneNumber
}

struct CeuUrlTypes {
    let appleStoreURL: URL
    let whatsappURL: URL
}

protocol CeuContactUsDelegate where Self: UIViewController {
    func showSuccessAlertMessage()
    func showErrorAlertMessage()
    func showLoadingView()
    func removeLoadingView()
}

protocol CeuContactUsViewModelProtocol {
    var delegate: CeuContactUsDelegate? { get set }
    var model: ContactUsModel? { get set }

    func setupParameters(message: String) -> [String: String]
    func setupURLs() throws -> CeuUrlTypes
    func sendMessageRequest(message: String)
    func fetchContactUsData()
    func handleFetchContactUsDataResquestSuccess(_ data: Data)
}

class CeuContactUsViewModel: CeuContactUsViewModelProtocol {
    var model: ContactUsModel?
    weak var delegate: CeuContactUsDelegate?

    func setupParameters(message: String) -> [String: String] {
        let email = model?.mail ?? ""
        let parameters: [String: String] = [
            "email": email,
            "mensagem": message
        ]
        return parameters
    }

    func setupURLs() throws -> CeuUrlTypes {
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

    // TODO: Criar Services.
    func sendMessageRequest(message: String) {
        let parameters = self.setupParameters(message: message)
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

    // TODO: Criar Services.
    func fetchContactUsData() {
        delegate?.showLoadingView()
        let url = Endpoints.contactUs
        AF.shared.request(url, method: .get, parameters: nil, headers: nil) { result in
            self.delegate?.removeLoadingView()
            switch result {
            case .success(let data):
                self.handleFetchContactUsDataResquestSuccess(data)
            case .failure(let error):
                self.delegate?.showErrorAlertMessage()
            }
        }
    }

    func handleFetchContactUsDataResquestSuccess(_ data: Data) {
        let decoder = JSONDecoder()
        if let returned = try? decoder.decode(ContactUsModel.self, from: data) {
            self.model = returned
        } else {
            self.delegate?.showErrorAlertMessage()
        }
    }
}

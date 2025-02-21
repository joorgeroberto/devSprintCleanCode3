//
//  CeuContactUsCoordinator.swift
//  CleanCodeApp
//
//  Created by Jorge de Carvalho on 20/02/25.
//
import UIKit

protocol CeuContactUsCoordinatorProtocol {
    func showErrorAlertMessage()
    func showSuccessAlertMessage()
}

class CeuContactUsCoordinator: CeuContactUsCoordinatorProtocol {
    weak var viewController: CeuContactUsViewController?
    func showErrorAlertMessage() {
        guard let viewController = viewController else { return }
        Globals.alertMessage(title: "Ops..", message: "Ocorreu algum erro", targetVC: viewController) {
            viewController.dismiss(animated: true)
        }
    }

    func showSuccessAlertMessage() {
        guard let viewController = viewController else { return }
        Globals.alertMessage(title: "Sucesso..", message: "Sua mensagem foi enviada", targetVC: viewController) {
            viewController.dismiss(animated: true)
        }
    }
}
extension CeuContactUsCoordinator {
    // MARK: Handle Click functions.
    func chatClicked(urls: CeuUrlTypes) {
        let canOpenWhatsappURL = UIApplication.shared.canOpenURL(urls.whatsappURL)
        if canOpenWhatsappURL {
            openURL(url: urls.whatsappURL)
        } else {
            openURL(url: urls.appleStoreURL)
        }
    }

    func phoneClick(tel: String?) {
        handleClick(string: tel, urlString: "tel://")
    }

    func emailClick(mail: String?) {
        handleClick(string: mail, urlString: "mailto:")
    }

    private func openURL(url: URL?) {
        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    private func handleClick(string: String?, urlString: String) {
        if let string = string,
           let url = URL(string: urlString + string) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

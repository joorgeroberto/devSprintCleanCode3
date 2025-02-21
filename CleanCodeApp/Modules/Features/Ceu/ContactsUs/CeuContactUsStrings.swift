//
//  CeuContactUsStrings.swift
//  CleanCodeApp
//
//  Created by Jorge de Carvalho on 20/02/25.
//

enum CeuContactUsStrings: String {
    // MARK: View Strings
    case writeYourMessage = "Escreva sua mensagem aqui"
    case chooseYourContactChannel = "Escolha o canal para contato"
    case orSendYourMessage = "Ou envie uma mensagem"
    case send = "Enviar"
    case goBack = "Voltar"

    // MARK: View Controller Strings
    case initFatalErrorMessage = "init(coder:) has not been implemented."

    // MARK: Coordinator Strings
    case ops = "Ops..."
    case anErrorOccurred = "Ocorreu algum erro"
    case success = "Sucesso"
    case yourMessageHasBeenSend = "Sua mensagem foi enviada"

    func localized() -> String {
        return self.rawValue
    }
}

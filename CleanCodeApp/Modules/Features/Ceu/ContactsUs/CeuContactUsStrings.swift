//
//  CeuContactUsStrings.swift
//  CleanCodeApp
//
//  Created by Jorge de Carvalho on 20/02/25.
//

enum CeuContactUsStrings: String {
//    // MARK: View Model Strings
//    case verifyEmailErrorMessage = "Verifique o e-mail informado."
//    case somethingWentWrongErrorMessage = "Algo de errado aconteceu. Tente novamente mais tarde."
//
    // MARK: View Strings
    case writeYourMessage = "Escreva sua mensagem aqui"
    case chooseYourContactChannel = "Escolha o canal para contato"
    case orSendYourMessage = "Ou envie uma mensagem"
    case send = "Enviar"
    case goBack = "Voltar"

    // MARK: View Controller Strings
    case initFatalErrorMessage = "init(coder:) has not been implemented."
//
    // MARK: Coordinator Strings
    case ops = "Ops..."
    case anErrorOccurred = "Ocorreu algum erro"
    case success = "Sucesso"
    case yourMessageHasBeenSend = "Sua mensagem foi enviada"
//
//    // MARK: CeuGlobalsProtocol Strings
//    case noConnection = "Sem Conexão"
//    case connectToInternetErroMessage = "Conecte-se à internet para tentar novamente"

    func localized() -> String {
        return self.rawValue
    }
}

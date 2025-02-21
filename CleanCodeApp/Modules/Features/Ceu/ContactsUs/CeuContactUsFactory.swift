//
//  CeuContactUsFactory.swift
//  CleanCodeApp
//
//  Created by Jorge de Carvalho on 20/02/25.
//

import UIKit

enum CeuContactUsFactory {
    static func make() -> UIViewController {
        let ceuContactUsViewModel = CeuContactUsViewModel()
        let ceuContactUsCoordinator = CeuContactUsCoordinator()
        let ceuContactUsViewController = CeuContactUsViewController(viewModel: ceuContactUsViewModel, coordinator: ceuContactUsCoordinator)

        ceuContactUsViewController.modalPresentationStyle = .fullScreen
        ceuContactUsViewController.modalTransitionStyle = .coverVertical

        ceuContactUsViewModel.delegate = ceuContactUsViewController
        ceuContactUsCoordinator.viewController = ceuContactUsViewController

        return ceuContactUsViewController
    }
}

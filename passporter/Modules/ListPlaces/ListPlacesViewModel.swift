//
//  ListPlacesViewModel.swift
//  passporter
//
//  Created by dgonzbal on 10/5/22.
//

import Foundation

protocol ListPlacesVMtoModelProtocol {
    func setData(data: [PlaceModel]?)
}

protocol ListPlacesVMtoViewProtocol {
    func getData()
    func search(text: String)
    func start()
    func select(item: PlaceModel?)
}

class ListPlacesViewModel {
    let view: ListPlacesViewControllerProtocol?
    var model: ListPlacesModelProtocol?
    
    init (view: ListPlacesViewControllerProtocol) {
        self.view = view
    }
}

// MARK: ListPlacesViewModelProtocol
extension ListPlacesViewModel: ListPlacesVMtoViewProtocol {
    func select(item: PlaceModel?) {
        guard let item = item else {
            return
        }
        let viewController = DetailPlacesViewController()
        viewController.setPlace(place: item)
        view?.navigateTo(view: viewController)
    }
    
    func getData() {
        model?.callService()
    }
    
    func search(text: String) {
        model?.getData(text: text)
    }
    
    func start() {
        self.model = ListPlacesModel(model: self)
        getData()
    }
}

// MARK: ListPlacesVMtoModelProtocol
extension ListPlacesViewModel: ListPlacesVMtoModelProtocol {
    func setData(data: [PlaceModel]?) {
        view?.setInfo(data: data)
    }
}

//
//  ListPlacesViewModel.swift
//  passporter
//
//  Created by dgonzbal on 10/5/22.
//

import Foundation

protocol ListPlacesModelProtocol {
    func callService()
    func getData(text: String)
}

class ListPlacesModel {
    private let viewModel: ListPlacesVMtoModelProtocol
    var data: DataResults?
    
    init (model: ListPlacesVMtoModelProtocol) {
        self.viewModel = model
    }
}

// MARK: ListPlacesModelProtocol
extension ListPlacesModel: ListPlacesModelProtocol {
    func callService() {
        let network = Network()
        network.getJson() { result in
            self.data = result
            self.viewModel.setData(data: result?.results)
        }
    }
    
    func getData(text: String) {
        if text.isEmpty {
            self.viewModel.setData(data: data?.results)
            return
        }
        var result = searchInNames(text: text)
        result?.append(contentsOf: searchInAddress(text: text) ?? [])
        self.viewModel.setData(data: result)
    }
}

// MARK: Search models
extension ListPlacesModel {
    private func searchInNames(text: String) -> [PlaceModel]? {
        let result = data?.results?.filter({ $0.name?.lowercased().contains(text.lowercased()) ?? false })
        return result
    }
    
    private func searchInAddress(text: String) -> [PlaceModel]? {
        let result = data?.results?.filter({ $0.address?.lowercased().contains(text.lowercased()) ?? false })
        return result
    }
}

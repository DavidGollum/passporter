//
//  passporterTests.swift
//  passporterTests
//
//  Created by dgonzbal on 10/5/22.
//

import XCTest
@testable import passporter

class passporterTests: XCTestCase {

    var sut: ListPlacesModel?
    let mockVM = ListPlacesVMtoModelMock()
    
    override func setUp() {
        sut = ListPlacesModel(model: mockVM)
        setMockData()
    }
    
    func testGetDataEmpty() {
        sut?.getData(text: "")
        XCTAssertEqual(mockVM.data?.count ?? 0, 3)
    }

    func testGetDataType1() {
        sut?.getData(text: "Name 1")
        XCTAssertEqual(mockVM.data?.first?.address ?? "", "address 1")
    }
    
    func testGetDataAddress() {
        sut?.getData(text: "Address 2")
        XCTAssertEqual(mockVM.data?.first?.name ?? "", "Name 2")
    }
    
    func testGetDataPartial() {
        sut?.getData(text: "Name")
        XCTAssertEqual(mockVM.data?.count ?? 0, 2)
    }
    
    func setMockData() {
        var placeModel: [PlaceModel] = []
        placeModel.append(PlaceModel(type: "type1", name: "Name 1", location: nil, address: "address 1", cover: nil))
        placeModel.append(PlaceModel(type: "type2", name: "Name 2", location: nil, address: "address 2", cover: nil))
        placeModel.append(PlaceModel(type: "type3", name: "Namito 3", location: nil, address: "address 3", cover: nil))
        let result = DataResults(results: placeModel)
        sut?.data = result
    }
}

class ListPlacesVMtoModelMock: ListPlacesVMtoModelProtocol {
    var data: [PlaceModel]?
    func setData(data: [PlaceModel]?) {
        self.data = data
    }
}

//
//  ChezTotoTests.swift
//  ChezTotoTests
//
//  Created by Amelie Pocchiolo on 13/02/2024.
//

import XCTest
@testable import ChezToto

final class ChezTotoTests: XCTestCase {
//    let app = XCUIApplication()
    var viewModel: ViewModel!

    // Test the ViewModel's initialization and its initial state:
    override func setUpWithError() throws {
        super.setUp()
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetDataLoadsData() {
        viewModel = ViewModel()
        
        let data: [TypeOfDish] = ModelData().load("Source.json")
        viewModel.getData()
        
        XCTAssertEqual(viewModel.menuArray.count, data.count, "Loaded data count should match menuArray count")
    }


    func testViewModelInitialization() {
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.menuArray.count, 2, "2")
    }

    func testAddDish() {
        let viewModel = ViewModel() // Re-initialize ViewModel
        let dish = Dish(name: "NewDish", description: "Description", price: 15)
        
        viewModel.addNewTypeOfDish(typeOfDish: "TestDish")
        viewModel.addDish(dish: dish, typeOfDish: "TestDish")
        
        XCTAssertEqual(viewModel.menuArray.first(where: { $0.name == "TestDish" })?.dishs.count, 1)
        XCTAssertEqual(viewModel.menuArray.first(where: { $0.name == "TestDish" })?.dishs.first?.name, "NewDish")
    }

    func testAddNewTypeOfDish() {
        let viewModel = ViewModel()

        viewModel.addNewTypeOfDish(typeOfDish: "NewTypeOfDish")

        XCTAssertEqual(viewModel.menuArray.count, 3, "Count should increase after adding a new type of dish")
    }

    func testAddDishToExistingType() {
        let viewModel = ViewModel()

        let dish = Dish(name: "NewDish", description: "Description", price: 13)
        viewModel.addDish(dish: dish, typeOfDish: "Entrées")

        XCTAssertEqual(viewModel.menuArray.first(where: { $0.name == "Entrées" })?.dishs.count, 3, "Count of dishes in 'Entrées' should increase after adding a dish")
    }

    
    func testRemoveDish() {
        let viewModel = ViewModel()

        let initialCount = viewModel.menuArray.first(where: { $0.name == "Pizzas" })?.dishs.count ?? 0

        viewModel.removeDish(dishName: "Margarita")

        let finalCount = viewModel.menuArray.first(where: { $0.name == "Pizzas" })?.dishs.count ?? 0

        XCTAssertNotEqual(finalCount, initialCount - 1, "4 - 3")
    }
}

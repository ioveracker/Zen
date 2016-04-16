//
//  ViewControllerSpec.swift
//  iOSTests
//
//  Created by Isaac Overacker on 4/15/16.
//
//

import Quick
import Nimble
import Moya
@testable import iOS

class ViewControllerSpec: QuickSpec {

    override func spec() {
        describe("zen view controller") {
            var viewController: ViewController!

            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateInitialViewController() as! ViewController
                viewController.loadView()
                viewController.gitHubAPI = MoyaProvider<GitHub>(
                    stubClosure: MoyaProvider.ImmediatelyStub)
            }

            it("intanstiates from the storyboard") {
                expect(viewController).toNot(beNil())
                expect(viewController.zenLabel.text) == "Anything added dilutes everything else."
            }

            context("when the zen button is tapped") {
                beforeEach {
                    viewController.zenButtonTapped(UIButton())
                }

                it("loads the sample data from the GitHub provider") {
                    expect(viewController.zenLabel.text) == "Design for failure."
                }
            }
        }
    }

}

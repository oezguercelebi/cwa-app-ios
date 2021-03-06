//
// Corona-Warn-App
//
// SAP SE and all other contributors
// copyright owners license this file to you under the Apache
// License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import Foundation
import XCTest
@testable import ENA
class ExposureSubmissionTanInputViewControllerTests: XCTestCase {

	private var service: MockExposureSubmissionService!

	override func setUp() {
		super.setUp()
		service = MockExposureSubmissionService()
	}

	private func createVC() -> ExposureSubmissionTanInputViewController {
		AppStoryboard.exposureSubmission.initiate(viewControllerType: ExposureSubmissionTanInputViewController.self) { coder -> UIViewController? in
			ExposureSubmissionTanInputViewController(coder: coder, coordinator: MockExposureSubmissionCoordinator(), exposureSubmissionService: self.service)
		}
	}

	func testTanInputSuccess() {
		let vc = createVC()
		_ = vc.view

		let expectation = self.expectation(description: "Call getRegistration service method.")
		service.getRegistrationTokenCallback = { deviceRegistrationKey, completion in
			expectation.fulfill()
			completion(.success(""))
		}

		vc.tanInput.insertText("234567893D")
		if vc.tanInput.isEnabled {
			_ = vc.enaTanInputDidTapReturn(vc.tanInput)
		}
		
		waitForExpectations(timeout: .short)
	}
}

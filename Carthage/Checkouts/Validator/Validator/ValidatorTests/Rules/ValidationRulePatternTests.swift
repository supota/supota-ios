/*

 ValidationRulePatternTests.swift
 Validator

 Created by @adamwaite.

 Copyright (c) 2015 Adam Waite. All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

*/

import XCTest
@testable import Validator

class ValidationRulePatternTests: XCTestCase {

    func testThatItCanValidateEmailAddresses() {
        
        let rule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: testError)

        for invalidEmail in ["user@invalid,com", "userinvalid.com", "invalid", "user@invalid@example.com"] {
            let invalid = Validator.validate(input: invalidEmail, rule: rule)
            XCTAssertFalse(invalid.isValid, invalidEmail)
        }
        
        for validEmail in ["user@valid.com", "user_1@valid.co.uk", "user@valid.museum"] {
            let valid = Validator.validate(input: validEmail, rule: rule)
            XCTAssertTrue(valid.isValid)
        }
        
    }
    
    func testThatItCanValidateDigitPresence() {
        
        let rule = ValidationRulePattern(pattern: ContainsNumberValidationPattern(), error: testError)
        
        for noDigitString in ["invalid", "invali_d", "inv+alid"] {
            let invalid = Validator.validate(input: noDigitString, rule: rule)
            XCTAssertFalse(invalid.isValid)
        }
        
        for digitString in ["valid1", "9valid"] {
            let valid = Validator.validate(input: digitString, rule: rule)
            XCTAssertTrue(valid.isValid)
        }
        
    }
}

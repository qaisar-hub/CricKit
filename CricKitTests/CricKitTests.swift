//
// CricKitTests.swift
// CricKitTests
//
// Created by gokul.krishnan on 22/09/23.
//

import XCTest

final class CricKitTests: XCTestCase {
  var sut: TextFieldObserver!

  override func setUpWithError() throws {
    sut = TextFieldObserver()
  }

  override func tearDownWithError() throws {
    sut = nil
  }
   
  func testFullName_success() {
    sut.fullName = "Gokul Krishnan"
    let result = sut.validateFullName()
    let expected = ""
    XCTAssertEqual(result, expected)
  }
   
  func testFullName_fail() {
    sut.fullName = ""
    let result = sut.validateFullName()
    let expected = "Full name should not be empty."
    XCTAssertEqual(result, expected)
  }
   
  func testEmail_success() {
    sut.emailId = "gokul@gmail.com"
    let result = sut.validateEmail()
    let expected = ""
    XCTAssertEqual(result, expected)
  }
   
  func testEmail_fail() {
    sut.emailId = ""
    let result = sut.validateEmail()
    let expected = "Email Id should not be empty."
    XCTAssertEqual(result, expected)
  }
   
  func testEmail_wrong() {
    sut.emailId = "yfdydf78687"
    let result = sut.validateEmail()
    let expected = "Invalid Email ID"
    XCTAssertEqual(result, expected)
  }
   
  func testPassword_success() {
    sut.password = "password"
    let result = sut.validatePassword()
    let expected = ""
    XCTAssertEqual(result, expected)
  }
   
  func testPassword_fail() {
    sut.password = ""
    let result = sut.validatePassword()
    let expected = "Password should not be empty"
    XCTAssertEqual(result, expected)
  }
   
  func testPassword_invalid() {
    sut.password = "pas"
    let result = sut.validatePassword()
    let expected = "Password should be at least 6 characters."
    XCTAssertEqual(result, expected)
  }
   
  func testConfirmPassword_empty() {
    sut.confirmPassword = ""
    let result = sut.validateConfirmPassword()
    let expected = "Confirm Password should not be empty."
    XCTAssertEqual(result, expected)
  }
   
  func testConfirmPassword_fail() {
    sut.password = "Password"
    sut.confirmPassword = "passwrd"
    let result = sut.validateConfirmPassword()
    let expected = "Passwords do not match."
    XCTAssertEqual(result, expected)
  }
   
  func testConfirmPassword_success() {
    sut.password = "Password"
    sut.confirmPassword = "Password"
    let result = sut.validateConfirmPassword()
    let expected = ""
    XCTAssertEqual(result, expected)
  }

}

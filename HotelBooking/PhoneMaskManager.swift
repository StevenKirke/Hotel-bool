//
//  PhoneMaskManager.swift
//  HotelBooking
//
//  Created by Steven Kirke on 21.12.2023.
//

import Foundation

protocol IPhoneMaskManager {
	func maskForNumber(phoneNumber: String) -> String
}

final class PhoneMaskManager: IPhoneMaskManager {

	enum MaskPhone: String {
		case mobile = "+X (XXX) XXX-XX-XX"
		case landline = "+XX XXXXXXXXXX"
	}

	func maskForNumber(phoneNumber: String) -> String {
		var tempNumber = ""
		switch phoneNumber.count {
		case 10:
			let assamply = "7" + phoneNumber
			tempNumber = formatMaskPhone(phone: assamply, mask: .mobile)
		case 11:
			tempNumber = formatMaskPhone(phone: phoneNumber, mask: .mobile)
		case 13:
			tempNumber = formatMaskPhone(phone: phoneNumber, mask: .landline)
		default:
			tempNumber = ""
		}

		return tempNumber
	}

	private func formatMaskPhone(phone: String, mask: MaskPhone) -> String {
		let currentMask = mask.rawValue
		var result = ""
		var index = phone.startIndex

		for element in currentMask where index < phone.endIndex {
			if element == "X" {
			result.append(phone[index])
				index = phone.index(after: index)
			} else {
				result.append(element)
			}
		}

		return result
	}
}

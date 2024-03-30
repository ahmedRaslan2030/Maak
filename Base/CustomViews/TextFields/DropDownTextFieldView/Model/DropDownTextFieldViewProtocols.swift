//
//  DropDownTextFieldViewProtocols.swift
//  WithYou
//
//  Created by Ahmed Raslan on 28/08/2023.
//

import Foundation

protocol DropDownTextFieldViewDelegate {
    func dropDownList(for textFieldView: DropDownTextFieldView) -> [DropDownItem]
    func didSelect(item: DropDownItem, for textFieldView: DropDownTextFieldView)
}
protocol DropDownTextFieldViewListDelegate {
    func didSelect(item: DropDownItem)
}


//
//  AddTransactionView.swift
//  DELIGHT_LABS_Subject
//
//  Created by MadCow on 2025/2/13.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: AddTransactionViewModel = AddTransactionViewModel()
    let saveCompletion: (Transaction) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    HStack {
                        ForEach(RecentTransactionFilterType.allCases, id: \.self) { segment in
                            if segment.rawValue != "All" {
                                CustomText(text: segment.rawValue,
                                           fontSize: 16,
                                           fontWeight: .bold,
                                           fontColor: viewModel.selectedTransactionCase == segment ? .white : .gray)
                                .frame(width: 86, height: 34)
                                .background(
                                    viewModel.selectedTransactionCase == segment ? Color.primaryColor : Color.clear
                                )
                                .clipShape(Capsule())
                                .onTapGesture {
                                    withAnimation(
                                        .easeInOut(duration: 0.2)
                                    ) {
                                        viewModel.selectedTransactionCase = segment
                                    }
                                }
                            }
                        }
                    }
                    .background(Color(UIColor.systemGray5))
                    .clipShape(Capsule())
                    
                    Spacer()
                    
                    CustomText(text: Date().dateToString(includeDay: .day),
                               fontSize: 18,
                               fontWeight: .semibold,
                               fontColor: .gray)
                    .padding(.top, 15)
                }
                .padding([.leading, .top, .trailing])
                
                VStack {
                    TextField("Name", text: $viewModel.name)
                        .frame(height: 10)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(UIColor.lightGray), lineWidth: 1)
                        )
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    
                    TextField("Amount", text: $viewModel.amount)
                        .frame(height: 10)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(UIColor.lightGray), lineWidth: 1)
                        )
                        .keyboardType(.decimalPad)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                HStack {
                                    Spacer()
                                    Button {
                                        hideKeyboard()
                                    } label: {
                                        Text("Done")
                                    }
                                }
                            }
                        }
                }
                .padding()
                .padding(.top, -10)
                
                Spacer()
                
                HStack {
                    CustomText(text: viewModel.selectedTransactionCase.rawValue,
                               font: .largeTitle,
                               fontColor: viewModel.selectedTransactionCase == .income ? Color.primaryColor : Color.expenseColor)
                    
                    Spacer()
                    
                    let account: Double = viewModel.amount.isEmpty ? 0 : Double(viewModel.amount) ?? 0
                    CustomText(text: viewModel.selectedTransactionCase == .income ?
                               "+$\(account.formattedSeparator())" :
                                "-$\(account.formattedSeparator())",
                               font: .title,
                               fontColor: viewModel.selectedTransactionCase == .income ? Color.primaryColor : Color.expenseColor,
                               allowsTightening: true)
                }
                .padding()
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .tint(.primaryColor)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addTransaction { transaction in
                            saveCompletion(transaction)
                            self.dismiss()
                        }
                    } label: {
                        Text("Save")
                    }
                    .tint(.primaryColor)
                    .disabled(!viewModel.buttonActivate)
                }
            }
        }
    }
}

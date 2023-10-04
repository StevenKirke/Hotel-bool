//
//  BookingView.swift
//  HotelBooking
//
//  Created by Steven Kirke on 10.09.2023.
//

import SwiftUI

struct BookingView: View {
    
    
    @Environment(\.presentationMode) var returnRoomsView: Binding<PresentationMode>
    
    var name: String = ""
    
    
    @ObservedObject var specification: GetSpecificationHotelViewModel = GetSpecificationHotelViewModel()
    @ObservedObject var touristList: TouristCartViewModel = TouristCartViewModel()
    
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationTabBar(label: "Бронирование",
                                   content:
                                    ButtonForNavigationTabBar(action: {
                self.returnRoomsView.wrappedValue.dismiss()
            })
            )
            ScrollView(.vertical ,showsIndicators: false) {
                VStack(spacing: 8) {
                    if specification.isLoadDesc {
                        HeaderBooking(info: specification.desc)
                        InformationView(info: specification.desc)
                    }
                    
                    BuyerInformation(textPhone: $touristList.phone,
                                     textEmail: $touristList.eMail)

                    ForEach(touristList.touristList.indices, id: \.self) { index in
                        let nameCard = touristList.nameTourist[index] + " турист"
                        let zeroIndex = index == 0 ? true : false
                        CardTourist(isShow: zeroIndex, currentTourist: $touristList.touristList[index], title: nameCard)
                    }

                    AddCardTourist(title: "Добавить туриста", action: {
                        self.touristList.addTourist()
                    })
                    
                    if specification.isLoadDesc {
                        CalculatePrice(price: specification.totalPrice)
                    }
                     if specification.isLoadDesc {
                        let assambly = "Оплатить " + specification.totalPrice.totalPrice
                        CustomTapBar(text: assambly, action: {
                            print(touristList.touristList)
                        })
                     }
                }
            }
        }
        .background(Color.c_F6F6F9)
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}


struct HeaderBooking: View {
    
    var info: Specification
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            GradeElement(grade: info.rating)
            Text(info.hotelName)
                .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                .lineLimit(2)
                .foregroundColor(.black)
            Button(action: {}) {
                Text(info.hotelAdress)
                    .modifier(HeightModifier(size: 14, lineHeight: 120, weight: .medium))
                    .lineLimit(1)
                    .foregroundColor(.c_0D72FF)
            }
            .disabled(true)
        }
        .solidBlackground()
    }
}

struct InformationView: View {
    
    var info: Specification
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            LabelForInfo(title: "Вылет из", text: info.departure)
            LabelForInfo(title: "Страна, город", text: info.arrivalCountry)
            LabelForInfo(title: "Даты", text: info.datas)
            LabelForInfo(title: "Кол-во ночей", text: info.numberOfNights)
            LabelForInfo(title: "Отель", text: info.hotelName)
            LabelForInfo(title: "Номер", text: info.room)
            LabelForInfo(title: "Питание", text: info.nutrition)
        }
        .solidBlackground()
    }
}

struct CalculatePrice: View {
    
    var price: TotalPrice
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            LabelForPrice(title: "Тур", text: price.tourPrice)
            LabelForPrice(title: "Топливный сбор", text: price.fuelCharge)
            LabelForPrice(title: "Сервисный сбор", text: price.serviceCharge)
            LabelForPrice(title: "К оплате", text: price.totalPrice, isSumm: true)
        }
        .solidBlackground()
    }
}


struct BuyerInformation: View {
    
    @State var isEmailValid: Bool = false
    @State var isPhoneValid: Bool = false
    @Binding var textPhone: String
    @Binding var textEmail: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Информация о покупателе")
                .modifier(HeightModifier(size: 22, lineHeight: 120, weight: .medium))
                .foregroundColor(.black)
                .padding(.bottom, 12)
            TextFieldForTouristWithPlaceholder(textField: $textEmail, title: "Номер телефона")
            TextFieldForTouristWithPlaceholder(textField: $textPhone, title: "Почта")
            Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                .modifier(HeightModifier(size: 14, lineHeight: 120, weight: .regular))
                .foregroundColor(.c_828796)
        }
        .solidBlackground()
    }
}



struct LabelForInfo: View {
    
    let title: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 40) {
            Text(title)
                .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
                .foregroundColor(.c_828796)
                .fixedSize()
                .frame(width: 100, alignment: .leading)
            Text(text)
                .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
                .foregroundColor(.black)
        }
    }
}


struct LabelForPrice: View {
    
    let title: String
    let text: String
    var isSumm: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 40) {
            Text(title)
                .modifier(HeightModifier(size: 16, lineHeight: 120, weight: .regular))
                .foregroundColor(.c_828796)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(text)
                .modifier(HeightModifier(size: 16, lineHeight: 120,
                                         weight: isSumm ? .semibold : .regular))
                .foregroundColor(isSumm ? .c_0D72FF : .black)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}


#if DEBUG
struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
#endif




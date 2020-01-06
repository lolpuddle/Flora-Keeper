import SwiftUI

struct PlantDetail: View {
    @Environment(\.editMode) var mode
    @EnvironmentObject var userData: UserData
    var plant: Plant
    
    var plantIndex: Int {
        userData.plants.firstIndex(where: { $0.id == plant.id })!
    }
    
    var rkManager3 = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 3)
    @State var multipleIsPresented = false
    
    var body: some View {
        VStack {
            CircleImage(image: plant.image)
            
            Text(verbatim:
                plant.name)
                .font(.largeTitle)
                .padding(.top, 20)
            
            Text(verbatim:
                plant.species)
                .font(.subheadline)
                .italic()
                .padding(.top, 10)
            
            VStack(alignment: .leading) {
                HStack() {
                    Text(verbatim: "Light\t")
                        .font(.title)
                    
                    
                    if (plant.lightLevel.rawValue == "Low") {
                         Rectangle()
                             .cornerRadius(20)
                             .frame(width: 20, height: 20)
                             .foregroundColor(Color(red: 255/255, green: 196/255, blue: 51/255, opacity: 1.0))
                     } else if (plant.lightLevel.rawValue == "Medium") {
                         Rectangle()
                             .cornerRadius(20)
                             .frame(width: 20, height: 20)
                             .foregroundColor(Color(red: 255/255, green: 196/255, blue: 51/255, opacity: 1.0))
                             .padding(.trailing, 10)
                        
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(red: 255/255, green: 196/255, blue: 51/255, opacity: 1.0))
                        
                     } else {
                         Rectangle()
                             .cornerRadius(20)
                             .frame(width: 20, height: 20)
                             .foregroundColor(Color(red: 255/255, green: 196/255, blue: 51/255, opacity: 1.0))
                             .padding(.trailing, 10)
                        
                        Rectangle()
                               .cornerRadius(20)
                               .frame(width: 20, height: 20)
                               .foregroundColor(Color(red: 255/255, green: 196/255, blue: 51/255, opacity: 1.0))
                               .padding(.trailing, 10)
                        
                        Rectangle()
                               .cornerRadius(20)
                               .frame(width: 20, height: 20)
                               .foregroundColor(Color(red: 255/255, green: 196/255, blue: 51/255, opacity: 1.0))
                               .padding(.trailing, 10)
                     }

                }
                
                HStack() {
                    Text(verbatim: "Water\t")
                        .font(.title)
                    
                    
                    if (plant.lightLevel.rawValue == "Low") {
                         Rectangle()
                             .cornerRadius(20)
                             .frame(width: 20, height: 20)
                             .foregroundColor(Color(red: 64/255, green: 234/255, blue: 212/255, opacity: 1.0))
                        
                     } else if (plant.lightLevel.rawValue == "Medium") {
                          Rectangle()
                              .cornerRadius(20)
                              .frame(width: 20, height: 20)
                              .foregroundColor(Color(red: 64/255, green: 234/255, blue: 212/255, opacity: 1.0))
                              .padding(.trailing, 10)
                         
                         Rectangle()
                                .cornerRadius(20)
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(red: 64/255, green: 234/255, blue: 212/255, opacity: 1.0))
                        
                     } else {
                         Rectangle()
                             .cornerRadius(20)
                             .frame(width: 20, height: 20)
                             .foregroundColor(Color(red: 64/255, green: 234/255, blue: 212/255, opacity: 1.0))
                             .padding(.trailing, 10)
                        
                        Rectangle()
                               .cornerRadius(20)
                               .frame(width: 20, height: 20)
                               .foregroundColor(Color(red: 64/255, green: 234/255, blue: 212/255, opacity: 1.0))
                               .padding(.trailing, 10)
                        
                        Rectangle()
                               .cornerRadius(20)
                               .frame(width: 20, height: 20)
                               .foregroundColor(Color(red: 64/255, green: 234/255, blue: 212/255, opacity: 1.0))
                               .padding(.trailing, 10)
                     }

                }
            }
            .padding()
            
            
            Button(action: { self.multipleIsPresented.toggle() }) {
                Text("Last Watered:").foregroundColor(.blue)
            }
            .sheet(isPresented: self.$multipleIsPresented, content: {
                RKViewController(isPresented: self.$multipleIsPresented, rkManager: self.rkManager3)})
            Text(self.getTextFromDate(date: self.rkManager3.selectedDates.last))
        }
    }
    
    func datesView(dates: [Date]) -> some View {
        ScrollView (.horizontal) {
            HStack {
                ForEach(dates, id: \.self) { date in
                    Text(self.getTextFromDate(date: date))
                }
            }
        }.padding(.horizontal, 15)
    }
    
    func startUp() {
        
        // example of pre-setting selected dates
        let testOnDates = [Date().addingTimeInterval(60*60*24), Date().addingTimeInterval(60*60*24*2)]
        rkManager3.selectedDates.append(contentsOf: testOnDates)
        
        // example of some foreground colors
        rkManager3.colors.weekdayHeaderColor = Color.blue
        rkManager3.colors.monthHeaderColor = Color.green
        rkManager3.colors.textColor = Color.blue
        rkManager3.colors.disabledColor = Color.red
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }
}

struct PlantDetail_Preview: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return PlantDetail(plant: userData.plants[3])
            .environmentObject(userData)
    }
}

//
//  UserParticipationView.swift
//  Lift
//
//  Created by Richard Hughes on 23/08/2020.
//  Copyright © 2020 dickieco. All rights reserved.
//

//  Summary of a User's performance inside the context of a UserGroup

// User's performance has a cap, only way to meet group goals is if there's collaboration. One person cannot work more in order to achieve what's required. Should never be a scenario where one person can do nothing and the group goals are achieved.



import SwiftUI

struct CompetitorView: View {
    
    @Environment(\.calendar) var calendar
    let competitor: Competable

    private var month: DateInterval {
        calendar.dateInterval(of: .month, for: Date())!
    }

    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.6931983232, green: 0.9235220551, blue: 0.6476737857, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center){

                //GIF
                CircleImage(imageName: self.competitor.pictureRef).frame(height: 240)
                
                Spacer()
                ProgressChartView()

                /*
                CalendarView(interval: month) { date in
                    Text("30")
                        .hidden()
                        .padding(6)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .padding(.vertical, 2)
                        .overlay(
                            Text(String(self.calendar.component(.day, from: date)))
                        )
                */
            }
        }

            
            
        }
        
}


// CHART STUFF

struct ProgressChartView: View {
    
    @State var pickerSelection = 0
    var body: some View {
        VStack {
            Picker(selection: $pickerSelection, label: Text("")) {
                Text("Group").tag(0)
                Text("Me").tag(1)

            }.pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal,24)
            Spacer()
            if pickerSelection == 0 {
                ZStack {
                    
                    HStack(alignment: .bottom) {
                        BarView(height: 240, value: 20, label: "Sun")
                        BarView(height: 240, value: 40, label: "Mon")
                        BarView(height: 240, value: 80, label: "Tue")
                        BarView(height: 240, value: 100, label: "Wed")
                        BarView(height: 240, value: 80, label: "Thu")
                        BarView(height: 240, value: 120, label: "Fri")
                        BarView(height: 240, value: 160, label: "Sat")
                        
                    }.padding(.top,12)
                    TargetLineView(height: 100)
                    
                }
                
            } else {
                HStack(alignment: .bottom) {
                    BarView(height: 240, value: 20, label: "Sun")
                    BarView(height: 240, value: 100, label: "Mon")
                    BarView(height: 240, value: 80, label: "Tue")
                    BarView(height: 240, value: 0, label: "Wed")
                    BarView(height: 240, value: 20, label: "Thu")
                    BarView(height: 240, value: 120, label: "Fri")
                    BarView(height: 240, value: 140, label: "Sat")
                    
                }.padding(.top,12)
                
                
            }
            
        }
    }
}

struct TargetLineView : View {
    var height: CGFloat
    
    var body: some View {
        
        GeometryReader { geo in
            Path { path in
                path.move(to: CGPoint(x: 24, y: height))
                path.addLine(to: CGPoint(x: (geo.size.width - 24), y: height))
            }.stroke(Color.red, lineWidth: 5)
        }
        
    }
    
}

struct BarView : View {
    
    
    var height: CGFloat
    var value: CGFloat
    var label: String
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                Capsule().frame(width: 30, height: height)
                    .foregroundColor(Color(#colorLiteral(red: 0.6282543121, green: 0.8383475479, blue: 0.585217456, alpha: 1)))
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(.white).overlay(Capsule().stroke(Color.blue, lineWidth: 1))
            }
            Text(label).padding(.top,2)
        }.padding(.horizontal,2)
    }
}


// CALENDAR STUFF
fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView

    init(
        interval: DateInterval,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }

    var body: some View {
        if #available(iOS 14.0, *) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(months, id: \.self) { month in
                    Section(header: header(for: month)) {
                        ForEach(days(for: month), id: \.self) { date in
                            if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                content(date).id(date)
                            } else {
                                content(date).hidden()
                            }
                        }
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 14.0, *) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(months, id: \.self) { month in
                    Section(header: header(for: month)) {
                        ForEach(days(for: month), id: \.self) { date in
                            if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                content(date).id(date)
                            } else {
                                content(date).hidden()
                            }
                        }
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    private func header(for month: Date) -> some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month

        return Group {
            if showHeaders {
                Text(formatter.string(from: month))
                    .font(.title)
                    .padding()
            }
        }
    }

    private func days(for month: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
}

struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let content: (Date) -> DateView

    init(
        month: Date,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.content = content
    }

    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: 1)
        )
    }

    var body: some View {
        VStack {
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
}

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let content: (Date) -> DateView

    init(
        week: Date,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.week = week
        self.content = content
    }

    
    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

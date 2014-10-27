//
//  CalendarViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "CalendarViewController.h"
#import "AddEventViewController.h"
#import "SACalendar.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface CalendarViewController () <SACalendarDelegate>
@property (weak, nonatomic) IBOutlet UIView *calendarContainerView;
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) SACalendar *calendar;
@property (strong, nonatomic) NSMutableDictionary *eventsHashedByStartDate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addEventButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CalendarViewController

- (void)addCalendarToView {
    UIView *parent = self.calendarContainerView;
    // Create the location of the calendar, which begins in the top left most corner of the screen, and spans
    // the width of the screen and half the height.
    CGSize screenDimensions = [UIScreen mainScreen].bounds.size;
    CGRect calendarFrame = CGRectMake(0, 0, screenDimensions.width, parent.frame.size.height);
    self.calendar = [[SACalendar alloc] initWithFrame:calendarFrame];
    [self.calendarContainerView addSubview:self.calendar];
    self.calendar.delegate = self;
}


-(void)SACalendar:(SACalendar *)calendar didDisplayCalendarForMonth:(int)month year:(int)year {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addEventButton.tintColor = flatironBlueDark;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadAllEvents];
    
    _eventsHashedByStartDate = [[NSMutableDictionary alloc] init];
    
    // When the calendar first loads, set the selected date to today.
    self.selectedDate = [NSDate date];

    // Add the calendar onto the screen
    [self addCalendarToView];
}

-(void)loadAllEvents {
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"RETRIEVED EVENTS FROM PARSE: %@", objects);
        self.calendar.events = objects;
        [self setEventsHashedByStartDateUsingEvents:objects];
//        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // If we are segueing to the detail view controller, pass the event.
    AddEventViewController *addVc = segue.destinationViewController;
    addVc.defaultDatePickerDate = self.selectedDate;
    addVc.delegate = self;
}

#pragma mark - utilities

-(NSString *)hashKeyForEvent:(PFObject *)event {
    return [self hashKeyForDate:event[@"startDate"]];
}

-(NSString *)hashKeyForDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitMonth) fromDate:date];
    return [self hashKeyForDay:[components day] month:[components month] year:[components year]];
}

-(NSString *)hashKeyForDay:(NSInteger)day month:(NSInteger)mon year:(NSInteger)yr {
    return [NSString stringWithFormat:@"%d%d%d", day, mon, yr];
}

-(void)setEventsHashedByStartDateUsingEvents:(NSArray *)events {
    [self.eventsHashedByStartDate removeAllObjects];
    for (PFObject *event in events) {
        
        // Get the has key for this event using its start date
        NSString *key = [self hashKeyForEvent:event];
        
        if (self.eventsHashedByStartDate[key]) {
            [((NSMutableArray *)self.eventsHashedByStartDate[key]) addObject:event];
        } else {
            self.eventsHashedByStartDate[key] = [NSMutableArray arrayWithObjects:event, nil];
        }
    }
}

-(NSArray *)eventsForDate:(NSDate *)date {
    NSArray *events = self.eventsHashedByStartDate[[self hashKeyForDate:date]];
    return events ? events : @[] ;
}

+(NSDate *)dateForDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = day;
    components.month = month;
    components.year = year;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

#pragma mark - SACalendarDelegate

-(void)SACalendar:(SACalendar *)calendar didSelectDate:(int)day month:(int)month year:(int)year {
    self.selectedDate = [[self class] dateForDay:day month:month year:year];
    [self.tableView reloadData];
}

#pragma mark - AddEventDelegate

-(void)addEventViewController:(id)addEventViewController didSaveEvent:(PFObject *)event{
    
}

-(void)addEventViewControllerDidCancel:(id)addEventViewController {
    [self dismissViewControllerAnimated:addEventViewController completion:nil];
}

#pragma mark - TableViewDelegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 26;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *header = [[UILabel alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [header setFont:[UIFont fontWithName:@"Arial-BoldMT" size:10]];
    header.backgroundColor = flatironBlueLight;
    header.text = [formatter stringFromDate:self.selectedDate];
    header.textColor = [UIColor whiteColor];
    return header;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [[self eventsForDate:self.selectedDate] count];
    
    // If there are no events, still return a count of 1, which will be the
    // noEventsCell.
    return count > 0 ? count : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get the events for the currently selected date
    NSArray *events = [self eventsForDate:self.selectedDate];
    
    UITableViewCell *cell;
    if ([events count] > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
        PFObject *event = (PFObject *)events[indexPath.row];
        cell.textLabel.text = event[@"title"];
        cell.detailTextLabel.text = [event[@"startDate"] description];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"noEventsCell" forIndexPath:indexPath];
    }
   
    return cell;
}

@end

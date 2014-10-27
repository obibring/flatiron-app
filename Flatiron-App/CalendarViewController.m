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
#import <Parse/Parse.h>

@interface CalendarViewController () <SACalendarDelegate>
@property (weak, nonatomic) IBOutlet UIView *calendarContainerView;
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) SACalendar *calendar;
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
    
    [self loadAllEvents];
    
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
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddEventViewController *addVc = segue.destinationViewController;
    addVc.defaultDatePickerDate = self.selectedDate;
    addVc.delegate = self;
}

#pragma mark - utilities

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
    NSLog(@"setting selected date to: %@", self.selectedDate);
}

#pragma mark - AddEventDelegate

-(void)addEventViewController:(id)addEventViewController didSaveEvent:(PFObject *)event{
    
}


-(void)addEventViewControllerDidCancel:(id)addEventViewController {
    [self dismissViewControllerAnimated:addEventViewController completion:nil];
}

@end

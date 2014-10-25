//
//  CalendarViewController.m
//  Flatiron-App
//
//  Created by Orr Bibring on 10/25/14.
//  Copyright (c) 2014 Orr Bibring. All rights reserved.
//

#import "CalendarViewController.h"
#import "SACalendar.h"

@interface CalendarViewController () <SACalendarDelegate>
@property (weak, nonatomic) IBOutlet UIView *calendarContainerView;
@property (strong, nonatomic) NSDate *selectedDate;
@end

@implementation CalendarViewController

- (void)addCalendarToView {
    UIView *parent = self.calendarContainerView;
    // Create the location of the calendar, which begins in the top left most corner of the screen, and spans
    // the width of the screen and half the height.
    CGSize screenDimensions = [UIScreen mainScreen].bounds.size;
    CGRect calendarFrame = CGRectMake(0, 0, screenDimensions.width, parent.frame.size.height);
    SACalendar *calendar = [[SACalendar alloc] initWithFrame:calendarFrame];
    [self.calendarContainerView addSubview:calendar];
    calendar.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // When the calendar first loads, set the selected date to today.
    self.selectedDate = [NSDate date];

    // Add the calendar onto the screen
    [self addCalendarToView];

    // Create the CALAgendaViewController
//    SACalendar *calendar = [[SACalendar alloc] initWithFrame:self.calendarViewContainer.frame];
    
//    [self.calendarViewContainer addSubview:calendar];
    
//    self.calVc = [CALAgendaViewController new];
//    self.calVc.agendaDelegate = self;
//    
//    // Set the start and end dates to be displayed in the calendar.
//    [self.calVc setFromDate:[[self class] firstDayOfCurrentMonth]];
//    [self.calVc setToDate:[[self class] lastDayOfCurrentMonth]];
//    
//    self.calVc.dayStyle = CALDayCollectionViewCellDayUIStyleIOS7;
//    self.calVc.events = @[];
//    self.calVc.calendarScrollDirection = UICollectionViewScrollDirectionHorizontal;
//    
//    self.calVc.view.frame = self.calContainer.frame;
//    
//    [self addChildViewController:self.calVc];
//    [self.calVc didMoveToParentViewController:self];
//    
//    [self.calContainer addSubview:self.calVc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

-(void)SACalendar:(SACalendar *)calendar didDisplayCalendarForMonth:(int)month year:(int)year {
    
}

@end

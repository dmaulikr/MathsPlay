//
//  LCMAndHCFViewController.m
//  KidsLearningGame
//
//  Created by qainfotech on 09/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "LCMAndHCFViewController.h"
#define BACKGROUND_COLOR [UIColor colorWithRed:85/255.0 green:192/255.0 blue:247/255.0 alpha:1]



@interface LCMAndHCFViewController ()
{
    NSArray *optionArray;
    int selectedIndex;
    int selectedAnswer;

}
@end

@implementation LCMAndHCFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1) {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    }
    else
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }
    self.navigationController.navigationBar.translucent = NO;
    // set bar title color
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor : [UIColor whiteColor]};
    // set  button color
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    
    NSString *str = @"1:45.PM";// put here item.TimeStart
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm.a"];// here give the format which you get in TimeStart
    
    NSDate *date = [dateFormatter dateFromString: str];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *convertedString = [dateFormatter stringFromDate:date];
    NSLog(@"Converted String : %@",convertedString);
    
    
    selectedAnswer=0;
    
    self.title=@"LCM and HCF";
    self.view.backgroundColor=BACKGROUND_COLOR;
    
    questionLabel=nil;
    questionLabel=[[UILabel alloc]initWithFrame:CGRectMake(84, 0, 600, 200)];
    questionLabel.backgroundColor=[UIColor clearColor];
    questionLabel.numberOfLines=0;
    questionLabel.textAlignment=NSTextAlignmentCenter;
    questionLabel.font = FONT;
    [self.view addSubview:questionLabel];
    
    submitButton=nil;
    submitButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitButton.frame=CGRectMake(219, 750, 300, 100);
    submitButton.titleLabel.font = FONT;
    [submitButton addTarget:self action:@selector(submitMethod) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    
    [self refreshQuestion];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(84, 200, 600, 500)
                                           style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    _tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}






-(void)submitMethod
{
  
    
    if (selectedIndex<4) {
        if (isCorrect) {
            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Correct !!" message:@"Your Answer is Correct" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [gameOver show];
            
        }
        else
        {
            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Wrong" message:@"Your Answer is inCorrect" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [gameOver show];
            
        }
        [self refreshQuestion];
    }
    else
    {
    
        UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Select at least one Option" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [gameOver show];
        

    }
    
   
}



// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Fresh Question

-(void)refreshQuestion
{
    int firstRandom=[self getRandomNumber:1 to:10];
    int secondRandom=[self getRandomNumber:1 to:10];
    answer=0;
    
    if (([self getRandomNumber:1 to:8]%2)==0) {
        
        questionLabel.text=[NSString stringWithFormat:@"The LCM of %i and %i ?",firstRandom,secondRandom];
        answer=lcm(firstRandom, secondRandom);
        
    }
    else
    {
        questionLabel.text=[NSString stringWithFormat:@"The HCF of %i and %i ?",firstRandom,secondRandom];
        answer=gcd(firstRandom, secondRandom);
    }
    optionArray=nil;
    optionArray=[[NSArray alloc]initWithArray:[self getShuffledArrayWithAnswer:[NSString stringWithFormat:@"%d",answer]]];
    selectedIndex=21323;
    [_tableView reloadData];
}








#pragma mark LOGICS in c
int gcd(int a, int b)
{
    for (;;)
    {
        if (a == 0) return b;
        b %= a;
        if (b == 0) return a;
        a %= b;
    }
}

int lcm(int a, int b)
{
    int temp = gcd(a, b);
    
    return temp ? (a / temp * b) : 0;
}

-(NSMutableArray *)getShuffledArrayWithAnswer:(NSString *)correctAnswer
{
    int localTemp=[correctAnswer integerValue];
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithCapacity:0];
    [tempArray addObject:[NSNumber numberWithInt:localTemp]];
    [tempArray addObject:[NSNumber numberWithInt:abs(localTemp-[self getRandomNumber:1 to:100])]];
    [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:1 to:100]]];
    [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:1 to:100]]];
    
    NSSet *uniqueTempArray=[NSSet setWithArray:tempArray];
    
    //check to avoid repeating option generated randomly..
    if (uniqueTempArray.count<tempArray.count) {
        [tempArray removeAllObjects];
        [tempArray addObject:[NSNumber numberWithInt:localTemp]];
        [tempArray addObject:[NSNumber numberWithInt:abs(localTemp-[self getRandomNumber:1 to:100])]];
        [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:101 to:150]]];
        [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:151 to:200]]];
    }
    
    
    for (int x = 0; x < [tempArray count]; x++) {
        int randInt = (arc4random() % ([tempArray count] - x)) + x;
        [tempArray exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    return tempArray;
}


#pragma mark segment Controll


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell.backgroundColor = CELL_COLOR;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    headerView.backgroundColor=[UIColor colorWithRed:126/255.0 green:188/255.0 blue:74/255.0 alpha:1.0];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 310, 100)];
    titleLabel.text=@"Options";
    titleLabel.font=[UIFont fontWithName:@"Futura" size:40];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor blackColor];
    [headerView addSubview:titleLabel];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return[optionArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static char i='a';
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell ;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.font=FONT;
    
    if(indexPath.row == selectedIndex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%c)  %@",i+indexPath.row,[optionArray objectAtIndex:indexPath.row]];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:30];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    selectedAnswer=[[optionArray objectAtIndex:indexPath.row] intValue];

    if (answer==selectedAnswer) {
        isCorrect=YES;
    }
    else
    {
        isCorrect=NO;
    }
    [tableView reloadData];
    
}
@end

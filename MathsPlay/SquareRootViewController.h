//
//  SquareRootViewController.h
//  KidsLearningGame
//
//  Created by qainfotech on 30/09/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModalBox.h"

@interface SquareRootViewController : UIViewController<UITextFieldDelegate>
{
    int correctCount;
    int incorrectCount;
    UILabel *sqrtLabel;
    UITextField *answer;
    UILabel *correctCountLabel;
    UILabel *incorrectCountLabel;
    NSMutableArray *tempArray;
    int complexity;
    int level;
    int QuestionCount;
    CustomModalBox *modal;
    UIImageView *moodImage;
    NSArray *questionArray;
    int Counter;
}
-(int)getRandomPerfectSquare;
-(void)showQuestion;
-(void)submitClicked;
-(void)refreshLabels;

@end

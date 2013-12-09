//
//  DivisibiltyCheckViewController.h
//  KidsLearningGame
//
//  Created by qainfotech on 01/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

#import "CustomModalBox.h"
#import "GiftView.h"

@interface DivisibiltyCheckViewController : UIViewController<ModalDelegate>
{
    int dividend;
    int divisor;
    UILabel *questionLabel;
    UIImageView *ant;
    CustomModalBox *modal;
    UILabel *builiding;
    GiftView *giftView;
}
-(void)winMusicStart;
-(void)displayQuestion;
-(void)correctAnswer;
-(void)incorrectAnswer;
-(void)answerClicked:(BOOL)answer;
- (int)getRandomNumber:(int)from to:(int)to;
-(void)initialAnimation;
-(void)startMethod:(UIButton *)sender;
@end

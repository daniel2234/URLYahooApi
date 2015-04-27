//
//  ViewController.h
//  YahooQuotes
//
//  Created by Daniel Kwiatkowski on 2015-04-27.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//UITextField
@property (strong, nonatomic) UITextField *textField;
@property (strong,nonatomic) UITextField  *timeChartField;
//String
@property (strong,nonatomic) NSString *quotes;
//UILabel
@property (strong,nonatomic) UILabel *priceLabel;
@property (strong,nonatomic) UILabel *dateLabel;
@property (strong,nonatomic) UILabel *timeLabel;
@property (strong,nonatomic) UILabel *priceChangeLabel;

//UIImageView
@property(strong,nonatomic)UIImageView *chartImageView;

@end


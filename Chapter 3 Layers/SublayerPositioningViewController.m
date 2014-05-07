//
//  SublayerPositioningViewController.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 7/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "SublayerPositioningViewController.h"

@interface SublayerPositioningViewController ()

@property (strong, nonatomic) CALayer *layer0;


@property (weak, nonatomic) IBOutlet UISlider *xPositionSlider;
@property (weak, nonatomic) IBOutlet UILabel *positionXLabel;

@property (weak, nonatomic) IBOutlet UISlider *yPositionSlider;
@property (weak, nonatomic) IBOutlet UILabel *positionYLabel;

@property (weak, nonatomic) IBOutlet UISlider *anchorPointXSlider;
@property (weak, nonatomic) IBOutlet UILabel *anchorPointXLabel;

@property (weak, nonatomic) IBOutlet UISlider *anchorPointYSlider;
@property (weak, nonatomic) IBOutlet UILabel *anchorPointYLabel;

@end

@implementation SublayerPositioningViewController


- (IBAction)xPositionChanged:(UISlider *)sender
{
    self.layer0.position = CGPointMake(sender.value, self.yPositionSlider.value);
    self.positionXLabel.text = [NSString stringWithFormat:@"%f", sender.value];
}


- (IBAction)yPositionChanged:(UISlider *)sender
{
    self.layer0.position = CGPointMake(self.xPositionSlider.value, sender.value);
    self.positionYLabel.text = [NSString stringWithFormat:@"%f", sender.value];
}


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
    // Do any additional setup after loading the view.
    
    self.layer0 = [CALayer new];
    self.layer0.frame = CGRectMake(0, 0, 100, 100);
    self.layer0.backgroundColor = [[UIColor blackColor] CGColor];
    [self.view.layer addSublayer:self.layer0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

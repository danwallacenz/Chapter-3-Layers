//
//  ViewController.m
//  Chapter 3 Layers
//
//  Created by Daniel Wallace [DATACOM] on 6/05/14.
//  Copyright (c) 2014 Daniel Wallace [DATACOM]. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *drawingView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self drawThreeLayers];
    [self drawTwoLayersAndAView];
}

-(void) drawTwoLayersAndAView
{
    CALayer *lay1 = [CALayer new];
    lay1.frame = CGRectMake(413, 11, 132, 194);
    lay1.backgroundColor = [[UIColor colorWithRed: 1 green: .4 blue: 1 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay1];
    
    CALayer *lay2 = [CALayer new];
    lay2.frame = CGRectMake(41, 56, 132, 194);
    lay2.backgroundColor = [[UIColor colorWithRed: .5 green: 1 blue: 0 alpha: 1] CGColor];
    [lay1 addSublayer:lay2];
    
    UIImageView* iv =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smileyiPhone"]];
    CGRect r = iv.frame;
    r.origin = CGPointMake(460,76);
    iv.frame = r;
    [self.drawingView addSubview:iv];
    
    CALayer *lay3 = [CALayer new];
    lay3.frame = CGRectMake(343, 97, 160, 230);
    lay3.backgroundColor = [[UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay3];
}

-(void) drawThreeLayers
{
    CALayer *lay1 = [CALayer new];
    lay1.frame = CGRectMake(113, 11, 132, 194);
    lay1.backgroundColor = [[UIColor colorWithRed: 1 green: .4 blue: 1 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay1];
    
    CALayer *lay2 = [CALayer new];
    lay2.frame = CGRectMake(41, 56, 132, 194);
    lay2.backgroundColor = [[UIColor colorWithRed: .5 green: 1 blue: 0 alpha: 1] CGColor];
    [lay1 addSublayer:lay2];
    
    CALayer *lay3 = [CALayer new];
    lay3.frame = CGRectMake(43, 97, 160, 230);
    lay3.backgroundColor = [[UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay3];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

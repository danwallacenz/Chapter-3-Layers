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

@property (strong, nonatomic) CALayer *lay11;


// Manipulating the layer heirarchy
@property (weak, nonatomic) UIView *layerHierarchyContainer;

@property (strong, nonatomic) CALayer *blueLayer;
@property (strong, nonatomic) CALayer *orangeLayer;
@property (strong, nonatomic) CALayer *yellowLayer;

@property (strong, nonatomic) CALayer *layerToInsertAndRemove;
@property (strong, nonatomic) CALayer *layerToInsertAndRemoveAtIndexZero;
@property (strong, nonatomic) CALayer *layerToInsertAndRemoveAtIndexOne;
@property (strong, nonatomic) CALayer *layerToInsertAndRemoveAtIndexTwo;
@property (strong, nonatomic) CALayer *layerToInsertAndRemoveAtIndexThree;

@end

@implementation ViewController

-(CALayer *)makeLayerToInsertAndRemove
{
    CALayer *layerToInsertAndRemove = [CALayer new];
    layerToInsertAndRemove.backgroundColor = [[UIColor colorWithWhite:0 alpha:1] CGColor];
    layerToInsertAndRemove.frame = CGRectMake(40, 40, 120, 120);
    return layerToInsertAndRemove;
}

-(CALayer *)makeLayerOfSize:(CGFloat) size atPosition:(CGFloat) origin withColor: (UIColor *)color
{
    CALayer *layer = [CALayer new];
    layer.backgroundColor = [[color colorWithAlphaComponent:0.8] CGColor];
    layer.frame = CGRectMake(origin, origin, size, size);
    return layer;
}

- (IBAction)insertLayerAtIndex0:(UISwitch *)sender
{
    if(sender.on){
        self.layerToInsertAndRemoveAtIndexZero = [self makeLayerOfSize: 120.0 atPosition: 0.0 withColor:[UIColor purpleColor]];
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertAndRemoveAtIndexZero atIndex: 0];
    }else{
        [self.layerToInsertAndRemoveAtIndexZero removeFromSuperlayer];
    }
}

- (IBAction)insertLayerAtIndex1:(UISwitch *)sender
{
    if(sender.on){
        self.self.layerToInsertAndRemoveAtIndexOne = [self makeLayerOfSize: 120.0 atPosition:20.0 withColor:[UIColor greenColor]];
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertAndRemoveAtIndexOne atIndex: 1];
    }else{
        [self.layerToInsertAndRemoveAtIndexOne removeFromSuperlayer];
    }
}

- (IBAction)insertLayerAtIndex2:(UISwitch *)sender
{
    if(sender.on){
        self.layerToInsertAndRemoveAtIndexTwo = [self makeLayerOfSize: 120.0 atPosition:40.0 withColor:[UIColor magentaColor]];
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertAndRemoveAtIndexTwo atIndex: 2];
    }else{
        [self.layerToInsertAndRemoveAtIndexTwo removeFromSuperlayer];
    }
}

- (IBAction)insertLayerAtIndex3:(UISwitch *)sender
{
    if(sender.on){
        self.layerToInsertAndRemoveAtIndexThree = [self makeLayerOfSize: 120.0 atPosition:60.0 withColor:[UIColor lightGrayColor]];
        [self.layerHierarchyContainer.layer insertSublayer: self.layerToInsertAndRemoveAtIndexThree atIndex: 3];
    }else{
        [self.layerToInsertAndRemoveAtIndexThree removeFromSuperlayer];
    }
}

#pragma mark actions

- (IBAction)addRemoveSublayer:(UISwitch *)sender
{
    if(sender.on){
        if (!self.layerToInsertAndRemove){
            self.layerToInsertAndRemove = [self makeLayerToInsertAndRemove];
        }
        self.layerToInsertAndRemove = [self makeLayerToInsertAndRemove];
        [self.yellowLayer addSublayer: self.layerToInsertAndRemove];
    }else{
        [self.layerToInsertAndRemove removeFromSuperlayer];
    }
}


- (IBAction)maskToBoundsChanged:(UISwitch *)sender
{
    self.lay11.masksToBounds = !self.lay11.masksToBounds;
}

- (IBAction)hiddenChanged:(UISwitch *)sender {
    self.lay11.hidden = !self.lay11.hidden;
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self drawThreeLayers];
    [self drawTwoLayersAndAView];
    [self drawThreeLayersToManipulateTheLayerHeirarchy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark drawing

-(void) drawThreeLayersToManipulateTheLayerHeirarchy
{
    UIView *layerHierarchyContainer = [[UIView alloc]initWithFrame:CGRectMake(100,420,300,300)];
    layerHierarchyContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:layerHierarchyContainer];
    
    self.blueLayer = [CALayer new];
    self.blueLayer.frame = CGRectMake(10, 10, 100, 100);
    self.blueLayer.backgroundColor = [[UIColor blueColor] CGColor];
    [layerHierarchyContainer.layer addSublayer: self.blueLayer];
    
    self.orangeLayer = [CALayer new];
    self.orangeLayer.frame = CGRectMake(50, 50, 100, 100);
    self.orangeLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    [layerHierarchyContainer.layer addSublayer: self.orangeLayer];
    
    self.yellowLayer = [CALayer new];
    self.yellowLayer.frame = CGRectMake(100, 100,100, 100);
    self.yellowLayer.backgroundColor = [[UIColor yellowColor] CGColor];
    [layerHierarchyContainer.layer addSublayer: self.yellowLayer];
    
    self.layerHierarchyContainer = layerHierarchyContainer;
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

-(void) drawTwoLayersAndAView
{
    self.lay11 = [CALayer new];
    self.lay11.frame = CGRectMake(413, 11, 132, 194);
    self.lay11.backgroundColor = [[UIColor colorWithRed: 1 green: .4 blue: 1 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:self.lay11];
    
    CALayer *lay21 = [CALayer new];
    lay21.frame = CGRectMake(41, 56, 132, 194);
    lay21.backgroundColor = [[UIColor colorWithRed: .5 green: 1 blue: 0 alpha: 1] CGColor];
    [self.lay11 addSublayer: lay21];
    
    UIImageView* iv =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smileyiPhone"]];
    CGRect r = iv.frame;
    r.origin = CGPointMake(460,76);
    iv.frame = r;
    [self.drawingView addSubview:iv];
    
    CALayer *lay31 = [CALayer new];
    lay31.frame = CGRectMake(343, 97, 160, 230);
    lay31.backgroundColor = [[UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1] CGColor];
    [self.drawingView.layer addSublayer:lay31];
}


@end

//
//  ViewController.m
//  TablePlusiPad
//
//  Created by Jialiang Xiang on 2015-06-08.
//
//

#import "ViewController.h"
#import "ConcreteWidgetView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *pieField;
@property (weak, nonatomic) IBOutlet UITextField *barField;
@property (weak, nonatomic) IBOutlet UITextField *numField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateValues:(id)sender {
    [(ConcreteWidgetView*)[self.view.subviews objectAtIndex:0] updatePieTo:self.pieField.text.doubleValue];
    [(ConcreteWidgetView*)[self.view.subviews objectAtIndex:0] updateBarTo:self.barField.text.doubleValue];
    [(ConcreteWidgetView*)[self.view.subviews objectAtIndex:0] updateNumTo:self.numField.text.doubleValue];
}

@end

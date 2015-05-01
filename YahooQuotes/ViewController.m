#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //create the textfield
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 60, 280, 20)];
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.text = @"";
    self.textField.placeholder = @"Input Ticker Symbol";
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate =self;
    [self.view addSubview:_textField];
    //create textfield for monthly charts
    self.timeChartField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 280, 20)];
    self.timeChartField.text = @"";
    self.timeChartField.placeholder = @"Input Month(s) ";
    [self.view addSubview:_timeChartField];

    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, 280, 40)];
    self.priceLabel.text = @"$0000000.00";
    [self.view addSubview:_priceLabel];
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 140, 280, 40)];
    self.dateLabel.text = @"00/00/0000";
    [self.view addSubview:_dateLabel];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, 280, 40)];
    self.timeLabel.text = @"00:00";
    [self.view addSubview:_timeLabel];
    
    self.priceChangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 180, 280, 40)];
    self.priceChangeLabel.text = @"000.00";
    [self.view addSubview:_priceChangeLabel];
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(20, 200, 280, 40);
    [myButton setTitle:@"Get Quote" forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(getQuote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
    
    self.chartImageView = [[UIImageView alloc] init];
    self.chartImageView.frame = CGRectMake(60.0, 400.0, 300.0, 300.0);
    [self.view addSubview:self.chartImageView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
//show data from chart
-(void)getChart
{
    NSString *chartURL = [NSString stringWithFormat:@"http://chart.finance.yahoo.com/z?s=%@&t=%@m",_textField.text,_timeChartField.text];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:chartURL]]];
    self.chartImageView.image = image;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    [self getQuote];
    return YES;
}


-(void)getQuote {
    [self getChart];//called with the selector
    //http://download.finance.yahoo.com/d/quotes.csv?s=%@&f=sl1d1t1c1ohgv&e=.csv
    NSString *quoteAddress = [NSString stringWithFormat:@"http://download.finance.yahoo.com/d/quotes.csv?s=%@&f=sl1d1t1c1ohgv&e=.csv",_textField.text];
    //create a url and format the url
    NSURL *theURL = [[NSURL alloc]initWithString:[quoteAddress stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSURLRequest *theRequest = [[NSURLRequest alloc]initWithURL:theURL];// create a request to the server
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];//createing a data object 
    NSMutableString *contentString = [[NSMutableString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *arrayData = [contentString componentsSeparatedByString:@","];
    float current = [[arrayData objectAtIndex:1]floatValue];
    float open = [[arrayData objectAtIndex:5]floatValue];
    
    if (current >= open) {
        _priceLabel.textColor = [UIColor greenColor];
    } else {
        _priceLabel.textColor = [UIColor redColor];
    }
    
    _priceLabel.text = [arrayData objectAtIndex:1];
    _dateLabel.text = [arrayData objectAtIndex:2];
    _timeLabel.text = [arrayData objectAtIndex:3];
    _priceChangeLabel.text = [arrayData objectAtIndex:4];
    
    NSLog(@"%@",contentString);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

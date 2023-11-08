//
//  ViewController.m
//  ExampleForiOS
//
//  Created by Gavery on 2023/11/7.
//

#import "ViewController.h"
#import "JWCHander.h"
#define ScreenBoundsSize ([[UIScreen mainScreen] bounds].size)
#define ScreenWidth ScreenBoundsSize.width
#define ScreenHeight ScreenBoundsSize.height
#define RpcUrl(Method) [NSString stringWithFormat:@"%@%@",RemoteRpcUrl,Method]
static NSString * const RemoteRpcUrl = @"http://192.168.1.119:41517/";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViews];
    // Do any additional setup after loading the view.
}
-(void)creatViews{
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.title = @"Demo";
    
    UIButton * b1 = [UIButton buttonWithType:UIButtonTypeSystem];
    b1.frame = CGRectMake(40, 120, ScreenWidth-80, 50);
    b1.backgroundColor = UIColor.whiteColor;
    [b1 setTitle:@"Create a new account" forState:UIControlStateNormal];
    [b1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(Create) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b1];
    
    UIButton * b2 = [UIButton buttonWithType:UIButtonTypeSystem];
    b2.frame = CGRectMake(40, CGRectGetMaxY(b1.frame) + 30, ScreenWidth-80, 50);
    b2.backgroundColor = UIColor.whiteColor;
    [b2 setTitle:@"Import mnemonic phrase" forState:UIControlStateNormal];
    [b2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(ImportMnemonic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b2];
    
    UIButton * b3 = [UIButton buttonWithType:UIButtonTypeSystem];
    b3.frame = CGRectMake(40, CGRectGetMaxY(b2.frame) + 30, ScreenWidth-80, 50);
    b3.backgroundColor = UIColor.whiteColor;
    [b3 setTitle:@"Import private key" forState:UIControlStateNormal];
    [b3 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [b3 addTarget:self action:@selector(ImportPrivate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b3];
    
    UIButton * b4 = [UIButton buttonWithType:UIButtonTypeSystem];
    b4.frame = CGRectMake(40, CGRectGetMaxY(b3.frame) + 30, ScreenWidth-80, 50);
    b4.backgroundColor = UIColor.whiteColor;
    [b4 setTitle:@"Get balance" forState:UIControlStateNormal];
    [b4 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [b4 addTarget:self action:@selector(Getbalance) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b4];
    
    UIButton * b5 = [UIButton buttonWithType:UIButtonTypeSystem];
    b5.frame = CGRectMake(40, CGRectGetMaxY(b4.frame) + 30, ScreenWidth-80, 50);
    b5.backgroundColor = UIColor.whiteColor;
    [b5 setTitle:@"Transfer" forState:UIControlStateNormal];
    [b5 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [b5 addTarget:self action:@selector(transfer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b5];
    
    UIButton * b6 = [UIButton buttonWithType:UIButtonTypeSystem];
    b6.frame = CGRectMake(40, CGRectGetMaxY(b5.frame) + 30, ScreenWidth-80, 50);
    b6.backgroundColor = UIColor.whiteColor;
    [b6 setTitle:@"Delegate" forState:UIControlStateNormal];
    [b6 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [b6 addTarget:self action:@selector(Delegate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b6];
    
    UIButton * b7 = [UIButton buttonWithType:UIButtonTypeSystem];
    b7.frame = CGRectMake(40, CGRectGetMaxY(b6.frame) + 30, ScreenWidth-80, 50);
    b7.backgroundColor = UIColor.whiteColor;
    [b7 setTitle:@"WithDraw" forState:UIControlStateNormal];
    [b7 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [b7 addTarget:self action:@selector(WithDraw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b7];
}


-(void)Create{
    [[JWCHander sharedManager] setProfileResult:^(NSString * _Nonnull out_private_key, NSString * _Nonnull out_public_key, NSString * _Nonnull mnemonic, NSString * _Nonnull walletAddress) {
        NSLog(@"--------------------------------------------------------------------------");
        NSLog(@"private key == %@", out_private_key);
        NSLog(@"mnemonics word == %@", mnemonic);
        NSLog(@"wallet address == %@", walletAddress);
        NSLog(@"--------------------------------------------------------------------------");
    }];
}

-(void)ImportMnemonic{
    NSString * mnemonic = @"opera chest thrive under lava ice great twice worry forget peanut pizza tube column roast iron method wood insect second flat tortoise behind stage";
    [[JWCHander sharedManager]importMnemonic:mnemonic result:^(NSString * _Nonnull out_private_key, NSString * _Nonnull out_public_key, NSString * _Nonnull walletAddress) {
        NSLog(@"--------------------------------------------------------------------------");
        NSLog(@"private key == %@", out_private_key);
        NSLog(@"wallet address == %@", walletAddress);
        NSLog(@"--------------------------------------------------------------------------");
    }];
}

-(void)ImportPrivate{
    NSString *  privatekey = @"9b44f384f667dce0598f5afdcb6a87d2dea05baec3b28c3fa5d4613589cb0526";
    [[JWCHander sharedManager]importpridata:privatekey result:^(NSString * _Nonnull out_public_key, NSString * _Nonnull walletAddress, NSString * _Nonnull mnemonic) {
        NSLog(@"--------------------------------------------------------------------------");
        NSLog(@"mnemonics word == %@", mnemonic);
        NSLog(@"wallet address == %@", walletAddress);
        NSLog(@"--------------------------------------------------------------------------");

    }];
}

-(void)Getbalance{
    NSMutableDictionary * paramars = [NSMutableDictionary dictionary];
    paramars[@"type"] = @"get_balance";
    paramars[@"addr"] = @"1HuxR6ytfngrqHyzN8xC9wHFCpg4QEoJkZ";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramars
                                                       options:kNilOptions
                                                         error:NULL];
    NSString *body = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:RpcUrl(@"get_balance")];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:bodyData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        NSDecimalNumber * walletprice = [NSDecimalNumber decimalNumberWithString:dic[@"balance"]];
        NSDecimalNumber * decimal = [NSDecimalNumber decimalNumberWithString:@"100000000"];
        NSDecimalNumber * yourPrice = [walletprice decimalNumberByDividingBy:decimal];
        NSLog(@"price == %@",[yourPrice stringValue]);
        NSLog(@"--------------------------------------------------------------------------");

    }];
    
    [sessionDataTask resume];
    
}

-(void)transfer{
    NSMutableDictionary * paramars = [NSMutableDictionary dictionary];
    paramars[@"type"] = @"tx_req";
    paramars[@"fromAddr"] = @[@"1HuxR6ytfngrqHyzN8xC9wHFCpg4QEoJkZ"];
    paramars[@"toAddr"] = @[@{@"addr":@"1LW5Z6GDqMs3T9FE67WRKHbdndiK3dWEzx",@"value":@"100"}];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramars
                                                       options:kNilOptions
                                                         error:NULL];
    NSString *body = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:RpcUrl(@"get_transaction_req")];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:bodyData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        NSString * message = result;
        NSString * ErrorCode = dic[@"ErrorCode"];
        
        if([ErrorCode isEqualToString:@"0"]){
            [[JWCHander sharedManager]sigWithmessage:message privateKey:@"5d8788572c472549ac27f053e7125b9f0561390ef931d23d133a062aa8f925b2" result:^(NSString * _Nonnull signature) {
                [self sendmesssage:signature];

            }];
        }
      
        NSLog(@"--------------------------------------------------------------------------");

    }];
    
    [sessionDataTask resume];

}



-(void)Delegate{
    NSMutableDictionary * paramars = [NSMutableDictionary dictionary];
    paramars[@"type"] = @"get_invest_req";
    paramars[@"fromAddr"] = @"1HuxR6ytfngrqHyzN8xC9wHFCpg4QEoJkZ";
    paramars[@"toAddr"] = @"131HeCSRUCVJPPo55UQZ18PyUFC64z469R";
    paramars[@"investType"] = @"0";
    paramars[@"invest_amount"] = @"1000";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramars
                                                       options:kNilOptions
                                                         error:NULL];
    NSString *body = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:RpcUrl(@"get_invest_req")];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:bodyData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        NSString * message = result;
        NSString * ErrorCode = dic[@"ErrorCode"];
        
        if([ErrorCode isEqualToString:@"0"]){
            [[JWCHander sharedManager]sigWithmessage:message privateKey:@"5d8788572c472549ac27f053e7125b9f0561390ef931d23d133a062aa8f925b2" result:^(NSString * _Nonnull signature) {
                [self sendmesssage:signature];

            }];
        }
      
        NSLog(@"--------------------------------------------------------------------------");

    }];
    
    [sessionDataTask resume];


}


-(void)WithDraw{
    NSMutableDictionary * paramars = [NSMutableDictionary dictionary];
    paramars[@"type"] = @"get_disinvest_req";
    paramars[@"fromAddr"] = @"1HuxR6ytfngrqHyzN8xC9wHFCpg4QEoJkZ";
    paramars[@"toAddr"] = @"131HeCSRUCVJPPo55UQZ18PyUFC64z469R";
    paramars[@"utxo_hash"] = @"The hash value obtained from the sendMessage method in the investment operation";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramars
                                                       options:kNilOptions
                                                         error:NULL];
    NSString *body = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:RpcUrl(@"get_disinvest_req")];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:bodyData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        NSString * message = result;
        NSString * ErrorCode = dic[@"ErrorCode"];
        
        if([ErrorCode isEqualToString:@"0"]){
            [[JWCHander sharedManager]sigWithmessage:message privateKey:@"5d8788572c472549ac27f053e7125b9f0561390ef931d23d133a062aa8f925b2" result:^(NSString * _Nonnull signature) {
                [self sendmesssage:signature];

            }];
        }
      
        NSLog(@"--------------------------------------------------------------------------");

    }];
    
    [sessionDataTask resume];
    
    


}


-(void)sendmesssage:(NSString *)message{
    
    NSData *bodyData = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:RpcUrl(@"SendMessage")];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:bodyData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        NSString *hash = dic[@"txhash"];
        
        NSString * ErrorCode = dic[@"ErrorCode"];
        
        if([ErrorCode isEqualToString:@"0"]){
            NSLog(@"%@",@"success");
        }
      
        NSLog(@"--------------------------------------------------------------------------");

    }];
    
    [sessionDataTask resume];
    
    
   
}

@end

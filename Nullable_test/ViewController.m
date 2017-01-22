//
//  ViewController.m
//  Nullable_test
//
//  Created by libo on 2017/1/22.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

//对NSArray、NSDictionary等添加nil值处理，使它们在插入或设置nil值时，也不会崩溃。
//原作者地址http://www.jianshu.com/p/c89b2716d60d
#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self testDictionaryNullable];
//    [self testArrayNullable];
    [self testNSNull];
}

- (void)testDictionaryNullable {

    id nilObj = nil;
    NSDictionary *dict = @{
                           @"aa":nilObj, //此处会引起崩溃
                           @"bb":@"bb"
                           };
    NSLog(@"dict: %@",dict);
    
    NSMutableDictionary *mDict = [NSMutableDictionary new];
    mDict[@"aaa"] = nilObj; //1.此处不会有问题
    [mDict setObject:@"bbb" forKey:@"bbb"];
    [mDict setObject:nilObj forKey:@"ccc"];//2.此处会引起崩溃
    NSLog(@"mDict:%@",mDict);
}
//注:mDict[@"aaa"]=nilObj;系统默认可以进行空值检查,不会有崩溃问题。所以以后还是推荐使用这种带下标的方法来写

- (void)testArrayNullable {
    id nilObj = nil;
    NSArray *array = @[@"aa",nilObj]; //3.此处会引起崩溃
    NSLog(@"%@",array);
    
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:0];
    mArray[0] = nilObj; //4.此处会引起崩溃
    [mArray addObject:nilObj]; //5.此处会引起崩溃
    [mArray addObject:@"bbb"];
    NSLog(@"mArray:%@",mArray);
}

- (void)testNSNull {
    NSString *nilObj = (NSString *)[NSNull null];
    NSLog(@"%lu",(unsigned long)[nilObj length]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

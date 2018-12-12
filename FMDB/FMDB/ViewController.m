//
//  ViewController.m
//  FMDB
//
//  Created by shenyong on 2018/12/12.
//  Copyright © 2018年 shenyong. All rights reserved.
//

#import "ViewController.h"
#import <FMDatabase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    searchBtn.backgroundColor = [UIColor redColor];
    [searchBtn setTitle:@"查找" forState:0];
    [searchBtn addTarget:self action:@selector(action_search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[NSString stringWithFormat:@"shopping%@.db",@"0001"]];
    // 找到路径下的数据库文件， 如果没有就会重新创建一个
    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
    if ([dataBase open]) {
        NSString *sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)";
        BOOL result = [dataBase executeUpdate:sql];
        if (result) {
            NSLog(@"create table success");
            
        }
        [dataBase close];
    }
}

- (void)searchDataFMDB{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[NSString stringWithFormat:@"shopping%@.db",@"0001"]];
    // 找到路径下的数据库文件， 如果没有就会重新创建一个
    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
    if ([dataBase open]) {
        NSString *sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)";
        [dataBase executeUpdate:sql];
        //查询条件
        NSString *searchs = @"SELECT name from t_student WHERE ID = ?";
        FMResultSet *result = [dataBase executeQuery:searchs,@"001"];
        //查到了
        if ([result next]) {
            NSString *name = [result objectForColumn:@"name"];
            NSLog(@"名字找到了是%@",name);
        }else{
             //没查到，那么插入一条
            NSLog(@"没找到");
            NSString *insertInfo = @"INSERT INTO t_student(ID,name,phone,score) VALUES (?,?,?,?);";
            [dataBase executeUpdate:insertInfo,@"001",@"带带大师兄",@"15826383768",@"99"];
            
        }
        
        [dataBase close];
    }
}
- (void)action_search{
    
    [self searchDataFMDB];
    
}


@end

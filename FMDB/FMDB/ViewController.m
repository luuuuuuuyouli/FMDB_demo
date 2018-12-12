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
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@"新增" forState:0];
    [addBtn addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 40)];
    searchBtn.backgroundColor = [UIColor greenColor];
    [searchBtn setTitle:@"查找" forState:0];
    [searchBtn addTarget:self action:@selector(action_search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    UIButton *deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 40)];
    deleBtn.backgroundColor = [UIColor redColor];
    [deleBtn setTitle:@"删除" forState:0];
    [deleBtn addTarget:self action:@selector(action_del) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleBtn];
    
    UIButton *changeBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 100, 40)];
    changeBtn.backgroundColor = [UIColor blueColor];
    [changeBtn setTitle:@"修改" forState:0];
    [changeBtn addTarget:self action:@selector(action_change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
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
- (void)deleteFMDB{
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
            NSLog(@"名字找到了是%@,我要删除他",name);
            //----->找到后删除
             NSString *delete = @"DELETE from 't_student' WHERE ID = ?";
        
              [dataBase executeUpdate:delete,@"001"];
        }else{
            //没查到
            NSLog(@"没查到");
        }
        
        [dataBase close];
    }
    
}

- (void)addDataFMDB{
    
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
            NSLog(@"已经有了哦%@",name);
        }else{
            //没查到，那么插入一条
            NSLog(@"没找到，那我新增一条");
            NSString *insertInfo = @"INSERT INTO t_student(ID,name,phone,score) VALUES (?,?,?,?);";
            [dataBase executeUpdate:insertInfo,@"001",@"带带大师兄",@"15826383768",@"99"];
            
        }
        
        [dataBase close];
    }
}

- (void)changeDataFMDB{
    
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
            NSLog(@"找到了是%@,我要修改他的名字",name);
            NSString *sql = @"update 't_student' set name = ?where ID = ?";
            [dataBase executeUpdate:sql,@"带带大师兄死了",@"001"];
            
        }else{
            //没查到，那么插入一条
            NSLog(@"没找到哦，你先新增一条");
            
        }
        
        [dataBase close];
    }
}



- (void)action_search{
    [self searchDataFMDB];
}

- (void)action_del{
    [self deleteFMDB];
}

- (void)action_add{
    [self addDataFMDB];
}

- (void)action_change{
    [self changeDataFMDB];
}

@end

//
//  ViewController.m
//  FMDB
//
//  Created by shenyong on 2018/12/12.
//  Copyright © 2018年 shenyong. All rights reserved.
//

#import "ViewController.h"
#import <FMDatabase.h>
#import "FMDatabaseQueue.h"

@interface ViewController ()

@property (nonnull, strong) FMDatabaseQueue * queue;

@property (nonatomic,strong) UIImageView *imageView;

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
    
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake(100, 500, 100, 100);
    [self.view addSubview:_imageView];
    
//    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[NSString stringWithFormat:@"shopping%@.db",@"0001"]];
//    // 找到路径下的数据库文件， 如果没有就会重新创建一个
//    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
//    if ([dataBase open]) {
//        NSString *sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL,'image' image blob)";
//        BOOL result = [dataBase executeUpdate:sql];
//        if (result) {
//            NSLog(@"create table success");
//
//        }
//        [dataBase close];
//    }
    //数据库在沙盒中的路径
    NSString * fileName = [[NSSearchPathForDirectoriesInDomains(13, 1, 1)lastObject]stringByAppendingPathComponent:@"testOfFMDB.sqlite"];
    NSLog(@"%@",fileName);
    
    //创建数据库
    self.queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            BOOL createTable = [db executeUpdate:@"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL,image)"];
            if (createTable) {
                NSLog(@"创建表成功");
            }
            else{
                NSLog(@"创建表失败");
            }
        }
        
        [db close];
    }];
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
    //[self searchDataFMDB];
    [self search];
}

- (void)action_del{
   // [self deleteFMDB];
}

- (void)action_add{
   // [self addDataFMDB];
    [self insert];
}

- (void)action_change{
   // [self changeDataFMDB];
}

- (void)insert{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            NSData * data = UIImageJPEGRepresentation([UIImage imageNamed:@"CX.jpg"], 0.1f);
            //sy
            NSData *data1 = UIImageJPEGRepresentation([UIImage imageNamed:@"sy.jpg"], 0.1f);
            NSArray *array = @[data,data1];
            BOOL flag = [db executeUpdate:@"INSERT INTO t_student(ID,name,phone,score,image) VALUES (?,?,?,?,?);",@"1001",@"shenyong",@"110",@"99",array];
            
            if (flag) {
                NSLog(@"插入成功");
            }else{
                NSLog(@"插入失败");
            }
        }
        [db close];
    }];
}
- (void)search{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            //返回查询数据的结果集
            FMResultSet * resultSet = [db executeQuery:@"select * from t_student"];
            //查询表中的每一个记录
            while ([resultSet next]) {
                
//                NSLog(@"%@",[resultSet stringForColumnIndex:0]);
//                NSLog(@"%@",[resultSet stringForColumnIndex:1]);
//                NSLog(@"%@",[resultSet stringForColumnIndex:2]);
//                NSLog(@"%@",[resultSet stringForColumnIndex:3]);
               // NSLog(@"%@",[resultSet stringForColumnIndex:4]);
//
//                NSLog(@"+++++++%@",[resultSet resultDictionary]);
                
               // NSString *ceshi = @"11 <<12321321>";
                
                
                NSString *string = [resultSet stringForColumnIndex:4];
                
                NSLog(@"%@",string);
                
//                NSArray *array = [[resultSet stringForColumnIndex:4] componentsSeparatedByString:@","];
//
//                NSLog(@"%@",array[0]);

             
//                NSData *data = [self convertHexStrToData:arr[0]];
//
//                UIImage * image = [UIImage imageWithData:data];
//
//                self.imageView.image = image;
                

                
            }
            
        }
        [db close];
    }];

   
}

- (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

- (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}


@end

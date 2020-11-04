//
//  QCDataBase.m
//  QCDemo
//
//  Created by JQC on 2020/10/30.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCDataBase.h"
//  声明全局变量关键字
static QCDataBase * dataBase = nil;

@interface QCDataBase ()

@property (nonatomic, nonnull, strong) FMDatabaseQueue * databaseQueue;

@end

@implementation QCDataBase

+ (QCDataBase *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[QCDataBase alloc] init];
    });
    return dataBase;
}




- (void)createFMDB{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath = [documentPath stringByAppendingPathComponent:@"chat.sqlite"];
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    NSLog(@"%@",filePath);
    [dataBase createChatTable];
    
}



//  所有消息数据库
- (void)createChatTable{
    
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            
            //  所有聊天记录
            BOOL chat =[database executeUpdate:@"CREATE TABLE IF NOT EXISTS chat (chatId text PRIMARY KEY NOT NULL, type text NOT NULL, uid text NOT NULL, rid text NOT NULL,msgid text NOT NULL, message text NOT NULL, time text NOT NULL, ctype text NOT NULL,  smsid text NOT NULL, gid text NOT NULL);"];
            
            
            //  聊天列表
            BOOL chatList = [database executeUpdate:@"CREATE TABLE IF NOT EXISTS chatList (id integer PRIMARY KEY AUTOINCREMENT,listId text NOT NULL,type text NOT NULL, uid text NOT NULL, rid text NOT NULL, msgid text NOT NULL, message text NOT NULL, time text NOT NULL, count text NOT NULL, headImage text NOT NULL, isTop text NOT NULL, isRead text NOT NULL);"];
            
            //  好友列表
            BOOL friendList = [database executeUpdate:@"CREATE TABLE IF NOT EXISTS friendList (associatedId text PRIMARY KEY NOT NULL, type text NOT NULL, uid text NOT NULL, rid text NOT NULL, msgid text NOT NULL, message text NOT NULL, time text NOT NULL, status text NOT NULL);"];
            
            if (chat) {
                NSLog(@"111");
            }
            if (chatList) {
                NSLog(@"222");
            }
            if (friendList) {
                NSLog(@"333");
            }
        }
    }];
    
}

#pragma mark - 数据库操作
-(void)insertChatModel:(QCChatModel *)model {
    
    
    
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            [database executeUpdate:@"INSERT INTO chat (chatId ,type, uid, rid, msgid, message, time, ctype, smsid, gid) VALUES (?,?,?,?,?,?,?,?,?,?);",model.chatId,model.type,model.uid,model.rid,model.msgid,model.message,model.time,model.ctype,model.smsid,model.gid];
            [database close];
            
        }else{
            
        }
        
    }];
    
}
-(void)deleteChatModel:(QCChatModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            
            [database executeUpdate:@"delete from chat where chatId = ?",model.chatId];
            [database close];
        }else{
            
        }
    }];
}
-(void)updateChatModel:(QCChatModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            //        [self.database executeUpdate:@"UPDATE car6 SET quantity = ?,productPrice = ?,productId = ?,productName = ?,productImg = ?,memberId = ?,productAttribute = ?,productDescription = ?,productPrice2Set = ?,productSn = ?,site = ? WHERE car6Id = ?",model.quantity,model.productPrice,model.productId,model.productName,model.productImg,model.memberId,model.productAttribute,model.productDescription,model.productPrice2Set,model.productSn,model.site,model.car6Id];
            [database close];
        }else{
            
            
        }
    }];
}
//  https://www.jianshu.com/p/859243acb24b
-(NSMutableArray *)queryChatModel:(QCChatModel *)model {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            
            //                SELECT * FROM chat while uid|000000|tid = @"11111"
            FMResultSet *set = [database executeQuery:@"SELECT * FROM chat where msgid = 888888 order by time ASC"];
            while ([set next]) {
                QCChatModel *model = [[QCChatModel alloc] init];
                model.chatId = [set stringForColumn:@"chatId"];

                model.type = [set stringForColumn:@"type"];
                model.uid = [set stringForColumn:@"uid"];
                model.rid = [set stringForColumn:@"rid"];
                model.msgid = [set stringForColumn:@"msgid"];
                model.message = [set stringForColumn:@"message"];
                model.time = [set stringForColumn:@"time"];
                model.ctype = [set stringForColumn:@"ctype"];
                model.smsid = [set stringForColumn:@"smsid"];
                model.gid = [set stringForColumn:@"gid"];

                [array addObject: model];
            }
            
            [database close];
            
        }else{
            
            
        }
    }];
    
    
    return array;
}

-(void)removeAllChatModel:(QCChatModel *)model {
    
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            [database executeUpdate:@"DELETE FROM chat"];
            [database close];
            
        }else{
            
            
        }
    }];
}

#pragma mark ----
-(void)insertListModel:(QCListModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            
            if ([database open]) {


                
                [database executeUpdate:@"INSERT INTO chatList (id,listId,type, uid, rid, msgid, message, time, count, headImage, isTop,isRead) VALUES (?,?,?,?,?,?,?,?,?,?,?,?);",database.lastInsertRowId,model.listId,model.type,model.uid,model.rid,model.msgid,model.message,model.time,model.count,model.headImage,model.isTop,model.isRead];
                

                
                
                [database close];
                
            }else{
                
            }
        }
        
    }];
    
}
-(void)deleteListModel:(QCListModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            [database executeUpdate:@"delete from chat where listId = ?",model.listId];
            [database close];
        }else{
            
        }
    }];
    
}
-(void)updateListModel:(QCListModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            //        [self.database executeUpdate:@"UPDATE car6 SET quantity = ?,productPrice = ?,productId = ?,productName = ?,productImg = ?,memberId = ?,productAttribute = ?,productDescription = ?,productPrice2Set = ?,productSn = ?,site = ? WHERE car6Id = ?",model.quantity,model.productPrice,model.productId,model.productName,model.productImg,model.memberId,model.productAttribute,model.productDescription,model.productPrice2Set,model.productSn,model.site,model.car6Id];
            [database close];
        }else{
            
            
        }
    }];
}
-(NSMutableArray *)queryListModel:(QCListModel *)model {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        if ([database open]) {
            FMResultSet *set = [database executeQuery:@"SELECT * FROM chatList ORDER BY isTop DESC , time DESC"];
            while ([set next]) {
                
                QCListModel * model = [[QCListModel alloc] init];
                model.listId = [set stringForColumn:@"listId"];
                model.type = [set stringForColumn:@"type"];
                model.uid = [set stringForColumn:@"uid"];
                model.rid = [set stringForColumn:@"rid"];
                model.msgid = [set stringForColumn:@"msgid"];
                model.message = [set stringForColumn:@"message"];
                model.time = [set stringForColumn:@"time"];
                model.count = [set stringForColumn:@"count"];
                model.headImage = [set stringForColumn:@"headImage"];
                model.isTop = [set stringForColumn:@"isTop"];
                [array addObject:model];
            }
            
            
            
            [database close];
            
        }else{
            
            
        }
    }];
    
    return array;
    
    
}

- (void )queryByListId:(QCListModel *)model {
    
    
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        if ([database open]) {
            
            
            NSString * str = [NSString stringWithFormat:@"SELECT * FROM chatList where listId = %@",model.listId];
            FMResultSet *set = [database executeQuery:str];
            
            while ([set next]) {
                NSString * countStr ;
                if ([model.isRead isEqualToString:@"0"] || model.isRead == nil) {
                    countStr = [NSString stringWithFormat:@"%d",([[set stringForColumn:@"count"] intValue] + 1)];

                }else{
                    countStr = @"0";
                }
                NSLog(@"%@",countStr);
                
                
                [database executeUpdate:@"UPDATE chatList SET message = ?,time = ? ,count = ? ,headImage = ? WHERE listId = ?",model.message,model.time,countStr,model.headImage,model.listId];
                
            }
            
            
            
            
            
            [database close];
            
        }else{
            
            
        }
    }];
    
    
}
-(void)removeAllListModel:(QCListModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            [database executeUpdate:@"DELETE FROM chatList"];
            [database close];
            
        }else{
            
            
        }
    }];
}

#pragma mark ----
-(void)insertAssociatedModel:(QCAssociatedModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            [database executeUpdate:@"INSERT INTO friendList (associatedId,type, uid, rid, msgid, message, time, status) VALUES (?,?,?,?,?,?,?,?,?);",model.associatedId,model.type,model.uid,model.rid,model.msgid,model.message,model.time,model.status];
            [self.database close];
            
        }else{
            
        }
    }];
    
}
-(void)deleteAssociatedModel:(QCAssociatedModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            [database executeUpdate:@"delete from chat where associatedId = ?",model.associatedId];
            [database close];
        }else{
            
        }
    }];
}
-(void)updateAssociatedModel:(QCAssociatedModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            //        [self.database executeUpdate:@"UPDATE car6 SET quantity = ?,productPrice = ?,productId = ?,productName = ?,productImg = ?,memberId = ?,productAttribute = ?,productDescription = ?,productPrice2Set = ?,productSn = ?,site = ? WHERE car6Id = ?",model.quantity,model.productPrice,model.productId,model.productName,model.productImg,model.memberId,model.productAttribute,model.productDescription,model.productPrice2Set,model.productSn,model.site,model.car6Id];
            [database close];
        }else{
            
            
        }
    }];
}
-(NSMutableArray *)queryAssociatedModel:(QCAssociatedModel *)model {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            
            //                SELECT * FROM chat while uid|000000|tid = @"11111"
            FMResultSet *set = [database executeQuery:@"SELECT * FROM friendList"];
            while ([set next]) {
                model.associatedId = [set stringForColumn:@"associatedId"];
                model.type = [set stringForColumn:@"type"];
                model.uid = [set stringForColumn:@"uid"];
                model.rid = [set stringForColumn:@"rid"];
                model.msgid = [set stringForColumn:@"msgid"];
                model.message = [set stringForColumn:@"message"];
                model.time = [set stringForColumn:@"time"];
                model.status = [set stringForColumn:@"status"];
                [array addObject: model];
            }
            
            [database close];
            
        }else{
            
            
        }
    }];
    
    NSLog(@"%ld",array.count);
    
    return array;
}
-(void)removeAllAssociatedModel:(QCAssociatedModel *)model {
    [self.databaseQueue inDatabase:^(FMDatabase * database) {
        
        
        if ([database open]) {
            [database executeUpdate:@"DELETE FROM friendList"];
            [database close];
            
        }else{
            
            
        }
    }];
}




@end

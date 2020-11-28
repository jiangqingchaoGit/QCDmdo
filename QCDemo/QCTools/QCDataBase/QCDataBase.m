//
//  QCDataBase.m
//  QCDemo
//
//  Created by JQC on 2020/10/30.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCDataBase.h"
#import "QCChatViewController.h"
#import "QCGroupChatViewController.h"

#import "QCMessageViewController.h"
#import "QCBookViewController.h"
#import "AppDelegate.h"
#import "QCCodeViewController.h"
//  声明全局变量关键字
static QCDataBase * dataBase = nil;

@interface QCDataBase ()

@property (nonatomic, nonnull, strong) FMDatabase * db;

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
    self.db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",filePath);
    [dataBase createChatTable];
    
}



//  所有消息数据库
- (void)createChatTable{
    
    
    
    if ([self.db open]) {
        
        //  所有聊天记录
        BOOL chat =[self.db  executeUpdate:@"CREATE TABLE IF NOT EXISTS chat (chatId text PRIMARY KEY NOT NULL, listId text NOT NULL, type text NOT NULL, uid text NOT NULL, rid text NOT NULL,msgid text NOT NULL, message text NOT NULL, time text NOT NULL, ctype text NOT NULL,  smsid text NOT NULL, gid text NOT NULL,mtype text NOT NULL, tohead text NOT NULL, tonick text NOT NULL,  uhead text NOT NULL, unick text NOT NULL,ghead text NOT NULL, gname text NOT NULL, isSend text NOT NULL,  canSend text NOT NULL, canMessage text NOT NULL);"];
        
        
        //  聊天列表
        BOOL chatList = [self.db  executeUpdate:@"CREATE TABLE IF NOT EXISTS chatList (id integer PRIMARY KEY AUTOINCREMENT,listId text NOT NULL,type text NOT NULL, uid text NOT NULL, rid text NOT NULL, msgid text NOT NULL, message text NOT NULL, time text NOT NULL, count text NOT NULL, isTop text NOT NULL, isRead text NOT NULL, isChat text NOT NULL,cType text NOT NULL,mtype text NOT NULL, tohead text NOT NULL, tonick text NOT NULL,  uhead text NOT NULL, unick text NOT NULL,ghead text NOT NULL, gname text NOT NULL,disturb text NOT NULL);"];
        
        //  好友列表
        BOOL friendList = [self.db  executeUpdate:@"CREATE TABLE IF NOT EXISTS friendList (associatedId text PRIMARY KEY NOT NULL, type text NOT NULL, uid text NOT NULL, rid text NOT NULL, msgid text NOT NULL, message text NOT NULL, time text NOT NULL, status text NOT NULL, applyid text NOT NULL, smsid text NOT NULL);"];
        
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
    
}

#pragma mark - 数据库操作
-(void)changeChatModel:(QCChatModel *)model {
    
    
    NSLog(@"%@",model.mtype);
    
        
        
        NSArray * arr = [model.message componentsSeparatedByString:@"|"];
        NSMutableArray * getArr = [[NSMutableArray alloc] initWithArray:arr];
        [getArr removeObjectAtIndex:0];
        [getArr insertObject:@"1" atIndex:0];
        NSString * messageStr = [getArr componentsJoinedByString:@"|"];
        
        
        if ([self.db  open]) {
            
            
            [self.db  executeUpdate:@"UPDATE chat SET message = ? WHERE chatId = ? ",messageStr,model.chatId];


            


            [self.db  close];
        }else{


        }
        

    
}

-(void)insertChatModel:(QCChatModel *)model {
    
    
    NSLog(@"%@",model.mtype);
    
    if ([model.mtype isEqualToString:@"14"]) {
        
        
        NSArray * arr = [model.message componentsSeparatedByString:@"|"];
        NSMutableArray * getArr = [[NSMutableArray alloc] initWithArray:arr];
        [getArr removeObjectAtIndex:0];
        [getArr insertObject:@"1" atIndex:0];
        NSString * messageStr = [getArr componentsJoinedByString:@"|"];
        
        
        if ([self.db  open]) {
            
            
            NSString * chatStr = [NSString stringWithFormat:@"SELECT * FROM chat where listId = '%@' and message like '%%%@%%' ",model.listId,arr[1]];
            FMResultSet *set = [self.db  executeQuery:chatStr];
            while ([set next]) {
                [self.db  executeUpdate:@"UPDATE chat SET message = ? WHERE message = ? ",messageStr,[set stringForColumn:@"message"]];
                

            }
            


            [self.db  close];
        }else{


        }
        
    }
    //  插入数据库
    if ([self.db  open]) {
        [self.db  executeUpdate:@"INSERT INTO chat (chatId, listId, type, uid, rid, msgid, message, time, ctype, smsid, gid, mtype, tohead, tonick, uhead, unick, ghead, gname,isSend, canSend, canMessage) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",model.chatId,model.listId,model.type,model.uid,model.rid,model.msgid,model.message,model.time,model.ctype,model.smsid,model.gid,model.mtype,model.tohead?model.tohead:@"",model.tonick?model.tonick:@"",model.uhead?model.uhead:@"",model.unick?model.unick:@"",model.ghead?model.ghead:@"",model.gname?model.gname:@"",model.isSend?model.isSend:@"",model.canSend?model.canSend:@"",model.canMessage?model.canMessage:@""];
        
        
        [self.db  close];
        
    }else{
        
    }
    
    
}
-(void)deleteChatModel:(QCChatModel *)model {
    
    
    if ([self.db  open]) {
        
        [self.db  executeUpdate:@"delete from chat where listId = ?" ,model.listId];
        [self.db  close];
    }else{
        
    }
}

-(void)deleteChatWithMtype:(NSString *)typeStr byListId:(NSString *)listId {
    
    
    if ([self.db  open]) {
        
        [self.db  executeUpdate:@"delete from chat   where mtype = ? and listId = ?",typeStr ,listId];
        [self.db  close];
    }else{
        
    }
}

-(void)updateChatModel:(NSString *)msgid {
    
    
    if ([self.db  open]) {
        [self.db  executeUpdate:@"UPDATE chat SET isSend = ? WHERE chatId = ?",@"1",msgid];
        
        
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCChatViewController class]]) {
            QCChatViewController * chatViewController = (QCChatViewController *)[QCClassFunction getCurrentViewController];
            [chatViewController GETTab];
        }
        
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCGroupChatViewController class]]) {
            QCGroupChatViewController * chatViewController = (QCGroupChatViewController *)[QCClassFunction getCurrentViewController];

            [chatViewController GETTab];
        }

        [self.db  close];
    }else{
        
        
    }
}

-(void)updateChatModelForMessage:(NSString *)msgid {
    
    
    if ([self.db  open]) {
        [self.db  executeUpdate:@"UPDATE chat SET message = ? WHERE chatId = ?",@"1",msgid];
        
        
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCChatViewController class]]) {
            QCChatViewController * chatViewController = (QCChatViewController *)[QCClassFunction getCurrentViewController];
            [chatViewController GETTab];
        }
        
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCGroupChatViewController class]]) {
            QCGroupChatViewController * chatViewController = (QCGroupChatViewController *)[QCClassFunction getCurrentViewController];

            [chatViewController GETTab];
        }

        [self.db  close];
    }else{
        
        
    }
}



-(NSMutableArray *)queryMsgId:(NSString *)msgId {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    
    
    if ([self.db  open]) {
        
        //                SELECT * FROM chat while uid|000000|tid = @"11111"
        NSString * chatStr = [NSString stringWithFormat:@"SELECT * FROM chat where chatId = '%@' order by time ASC",msgId];
        FMResultSet *set = [self.db  executeQuery:chatStr];
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
            model.listId = [set stringForColumn:@"listId"];
            model.mtype = [set stringForColumn:@"mtype"];
            
            model.tohead = [set stringForColumn:@"tohead"];
            model.tonick = [set stringForColumn:@"tonick"];
            model.uhead = [set stringForColumn:@"uhead"];
            model.unick = [set stringForColumn:@"unick"];
            model.ghead = [set stringForColumn:@"ghead"];
            model.gname = [set stringForColumn:@"gname"];
            
            model.canMessage = [set stringForColumn:@"canMessage"];
            model.canSend = [set stringForColumn:@"canSend"];
            model.isSend = [set stringForColumn:@"isSend"];

            
            [array addObject: model];
        }
        
        [self.db  close];
        
    }else{
        
        
    }
    
    
    return array;
}


-(NSMutableArray *)GETARRWithListId:(NSString *)listId withContent:(NSString *)content {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    
    
    if ([self.db  open]) {
        
        //                SELECT * FROM chat while uid|000000|tid = @"11111"
        NSString * chatStr = [NSString stringWithFormat:@"SELECT * FROM chat where listId = '%@' and message like '%%%@%%' order by time DESC",listId,content];
        FMResultSet *set = [self.db  executeQuery:chatStr];
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
            model.listId = [set stringForColumn:@"listId"];
            model.mtype = [set stringForColumn:@"mtype"];
            
            model.tohead = [set stringForColumn:@"tohead"];
            model.tonick = [set stringForColumn:@"tonick"];
            model.uhead = [set stringForColumn:@"uhead"];
            model.unick = [set stringForColumn:@"unick"];
            model.ghead = [set stringForColumn:@"ghead"];
            model.gname = [set stringForColumn:@"gname"];
            
            model.canMessage = [set stringForColumn:@"canMessage"];
            model.canSend = [set stringForColumn:@"canSend"];
            model.isSend = [set stringForColumn:@"isSend"];

            
            [array addObject: model];
        }
        
        [self.db  close];
        
    }else{
        
        
    }
    
    
    return array;
}


-(NSMutableArray *)queryChatModel:(NSString *)listId {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    
    
    if ([self.db  open]) {
        
        //                SELECT * FROM chat while uid|000000|tid = @"11111"
        NSString * chatStr = [NSString stringWithFormat:@"SELECT * FROM chat where listId = '%@' order by time ASC",listId];
        FMResultSet *set = [self.db  executeQuery:chatStr];
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
            model.listId = [set stringForColumn:@"listId"];
            model.mtype = [set stringForColumn:@"mtype"];
            model.tohead = [set stringForColumn:@"tohead"];
            model.tonick = [set stringForColumn:@"tonick"];
            model.uhead = [set stringForColumn:@"uhead"];
            model.unick = [set stringForColumn:@"unick"];
            model.ghead = [set stringForColumn:@"ghead"];
            model.gname = [set stringForColumn:@"gname"];
            model.canMessage = [set stringForColumn:@"canMessage"];
            model.canSend = [set stringForColumn:@"canSend"];
            model.isSend = [set stringForColumn:@"isSend"];

            

            if ([model.mtype isEqualToString:@"0"]) {
                                
                NSDictionary * dic = [QCClassFunction dictionaryWithJsonString:model.message];
                NSAttributedString * attributedString = [QCClassFunction stringToAttributeString:dic[@"message"]];
                
                CGSize attSize = [attributedString boundingRectWithSize:CGSizeMake(KSCALE_WIDTH(221), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
                
                if (attSize.height <= 24) {

                    model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(72)];

                }else{

                    model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(45) + attSize.height];

                }
            }

            if ([model.mtype isEqualToString:@"1"]) {
                //  图片  90 * 120

                NSArray * arr = [model.message componentsSeparatedByString:@"|"];


                if ([arr[1] floatValue] > [arr[2] floatValue]) {
                    model.cellH = [NSString stringWithFormat:@"%f",[arr[1] floatValue] * KSCALE_WIDTH(90) / [arr[2] floatValue] + KSCALE_WIDTH(20)];

                } else if ([arr[1] floatValue] == [arr[2] floatValue]){
                    model.cellH = [NSString stringWithFormat:@"%f",[arr[1] floatValue] * KSCALE_WIDTH(120) / [arr[2] floatValue] + KSCALE_WIDTH(20)];

                }else {
                    model.cellH = [NSString stringWithFormat:@"%f",[arr[1] floatValue] * KSCALE_WIDTH(150) / [arr[2] floatValue] + KSCALE_WIDTH(20)];

                }



            }
            if ([model.mtype isEqualToString:@"2"]) {
                //  yuyin
                model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(72)];

            }
            
            if ([model.mtype isEqualToString:@"3"] || [model.mtype isEqualToString:@"6"]) {
                //  红包
                model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(108.5)];

            }
            if ([model.mtype isEqualToString:@"5"]) {
                //  chuoyichuo
                model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(72)];

            }
            if ([model.mtype isEqualToString:@"10"]) {
                //  时间
                model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(30)];

            }

            if ([model.mtype isEqualToString:@"11"]) {
                //  被拒绝
                model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(30)];

            }
            
            if ([model.mtype isEqualToString:@"13"] || [model.mtype isEqualToString:@"14"]) {
                //  转账
                model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(108.5)];

            }
            if ([model.mtype isEqualToString:@"18"]) {
                //  领取红包
                model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(30)];

            }
            
            if ([model.mtype isEqualToString:@"20"]) {
                //  禁言
                model.cellH = [NSString stringWithFormat:@"%f",KSCALE_WIDTH(30)];

            }

            if ([model.mtype isEqualToString:@"4"]) {
                NSArray * arr = [model.message componentsSeparatedByString:@"|"];


                if ([arr[1] floatValue] > [arr[2] floatValue]) {
                    model.cellH = [NSString stringWithFormat:@"%f",[arr[1] floatValue] * KSCALE_WIDTH(90) / [arr[2] floatValue] + KSCALE_WIDTH(20)];

                } else if ([arr[1] floatValue] == [arr[2] floatValue]){
                    model.cellH = [NSString stringWithFormat:@"%f",[arr[1] floatValue] * KSCALE_WIDTH(120) / [arr[2] floatValue] + KSCALE_WIDTH(20)];

                }else {
                    model.cellH = [NSString stringWithFormat:@"%f",[arr[1] floatValue] * KSCALE_WIDTH(150) / [arr[2] floatValue] + KSCALE_WIDTH(20)];

                }
            }

            

            
            
            [array addObject: model];
        }
        
        [self.db  close];
        
    }else{
        
        
    }
    
    
    return array;
}

-(void)removeAllChatModel:(QCChatModel *)model {
    
    
    
    if ([self.db  open]) {
        [self.db  executeUpdate:@"DELETE FROM chat"];
        [self.db  close];
        
    }else{
        
        
    }
}

#pragma mark ----
-(void)insertListModel:(QCListModel *)model {
    
    
    
    if ([self.db  open]) {
        
        
        
        [self.db  executeUpdate:@"INSERT INTO chatList (id,listId,type, uid, rid, msgid, message, time, count, isTop,isRead, isChat,cType,mtype,disturb) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",self.db .lastInsertRowId,model.listId,model.type,model.uid,model.rid,model.msgid,model.message,model.time,model.count,model.isTop,model.isRead,model.isChat,model.cType,model.mtype,model.disturb];
        
        
        
        
        [self.db  close];
        
    }else{
        
    }
    
    
}
-(void)deleteListModel:(QCListModel *)model {
    
    
    if ([self.db  open]) {
        [self.db  executeUpdate:@"delete from chatList where listId = ?",model.listId];
        [self.db  close];
    }else{
        
    }
    
}
-(void)updateListModel:(QCListModel *)model {
    
    
    if ([self.db  open]) {
        //        [self.database executeUpdate:@"UPDATE car6 SET quantity = ?,productPrice = ?,productId = ?,productName = ?,productImg = ?,memberId = ?,productAttribute = ?,productDescription = ?,productPrice2Set = ?,productSn = ?,site = ? WHERE car6Id = ?",model.quantity,model.productPrice,model.productId,model.productName,model.productImg,model.memberId,model.productAttribute,model.productDescription,model.productPrice2Set,model.productSn,model.site,model.car6Id];
        [self.db  close];
    }else{
        
        
    }
}
-(NSMutableArray *)querywithListId:(NSString *)listId {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    if ([self.db  open]) {
        
        NSString * str = [NSString stringWithFormat:@"SELECT * FROM chatList where  listId = '%@'",listId];
        FMResultSet *set = [self.db  executeQuery:str];
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
            model.isTop = [set stringForColumn:@"isTop"];
            model.isChat = [set stringForColumn:@"isChat"];
            model.cType = [set stringForColumn:@"cType"];
            model.mtype = [set stringForColumn:@"mtype"];
            model.tohead = [set stringForColumn:@"tohead"];
            model.tonick = [set stringForColumn:@"tonick"];
            model.uhead = [set stringForColumn:@"uhead"];
            model.unick = [set stringForColumn:@"unick"];
            model.ghead = [set stringForColumn:@"ghead"];
            model.gname = [set stringForColumn:@"gname"];
            model.disturb = [set stringForColumn:@"disturb"];

            
            
            [array addObject:model];
        }
        
        
        
        [self.db  close];
        
    }else{
        
        
    }
    
    return array;

}
-(NSMutableArray *)queryListModel:(QCListModel *)model {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    if ([self.db  open]) {
        
        NSString * str = [NSString stringWithFormat:@"SELECT * FROM chatList where  rid = '%@' ORDER BY isTop DESC , time DESC",K_UID];
        FMResultSet *set = [self.db  executeQuery:str];
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
            model.isTop = [set stringForColumn:@"isTop"];
            model.isChat = [set stringForColumn:@"isChat"];
            model.cType = [set stringForColumn:@"cType"];
            model.mtype = [set stringForColumn:@"mtype"];
            model.tohead = [set stringForColumn:@"tohead"];
            model.tonick = [set stringForColumn:@"tonick"];
            model.uhead = [set stringForColumn:@"uhead"];
            model.unick = [set stringForColumn:@"unick"];
            model.ghead = [set stringForColumn:@"ghead"];
            model.gname = [set stringForColumn:@"gname"];
            model.disturb = [set stringForColumn:@"disturb"];

            
            
            [array addObject:model];
        }
        
        
        
        [self.db  close];
        
    }else{
        
        
    }
    
    return array;
    
    
}

- (void )queryByListId:(QCListModel *)model {
    
    
    if ([self.db  open]) {
        
        
        NSString * str = [NSString stringWithFormat:@"select * from chatList where listId = '%@'",model.listId];
        FMResultSet * set = [self.db  executeQuery:str];
        
        
  
        if ([set next]) {
            
            //  有数据进行更改
            NSString * countStr ;
            if ([model.isRead isEqualToString:@"0"] || model.isRead == nil) {
                
                if ( [[set stringForColumn:@"disturb"] isEqualToString:@"0"]) {
                    countStr = [NSString stringWithFormat:@"%d",([[set stringForColumn:@"count"] intValue] + 1)];

                }else{
                    countStr = @"0";

                }
                    
            }else{
                countStr = @"0";

            }
            
            NSString * isChat ;
            if ([model.isChat isEqualToString:@"0"]) {
  
                
                isChat = [set stringForColumn:@"isChat"] ;
            }
            
            if ([model.isChat isEqualToString:@"1"]) {
                
                isChat = @"0";
                
            }
            if ([model.isChat isEqualToString:@"2"]) {
                isChat = @"1";

            }

            
            [self.db  executeUpdate:@"UPDATE chatList SET message = ?,time = ? ,count = ?  ,isChat = ?,tohead = ? ,tonick = ? ,uhead = ? ,unick = ? ,ghead = ? ,gname = ? ,mtype = ? WHERE listId = ?",model.message,model.time,countStr,isChat,model.tohead?model.tohead:@"",model.tonick?model.tonick:@"",model.uhead?model.uhead:@"",model.unick?model.unick:@"",model.ghead?model.ghead:@"",model.gname?model.gname:@"",model.mtype,model.listId];

            
            
            if ([isChat isEqualToString:@"1"]) {
                NSLog(@"聊天中");
                
                if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCChatViewController class]]) {
                    QCChatViewController * chatViewController = (QCChatViewController *)[QCClassFunction getCurrentViewController];
                    [chatViewController GETDATA];
                }
                
                if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCGroupChatViewController class]]) {
                    QCGroupChatViewController * chatViewController = (QCGroupChatViewController *)[QCClassFunction getCurrentViewController];
                    [chatViewController GETDATA];
                }

                
            }else{

                NSLog(@"没有聊天中");
                
            }
            
            
            
        }else{
            
            if (model.message  == nil || [model.message isEqualToString:@""]) {
                return;
            }
            
            
            //  没有数据添加数据
            [self.db  executeUpdate:@"INSERT INTO chatList (id,listId,type, uid, rid, msgid, message, time, count, isTop,isRead,isChat,cType,mtype, tohead, tonick, uhead, unick, ghead, gname, disturb) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",self.db .lastInsertRowId,model.listId,model.type,model.uid,model.rid,model.msgid,model.message,model.time,model.count,model.isTop,model.isRead,model.isChat,model.cType,model.mtype,model.tohead?model.tohead:@"",model.tonick?model.tonick:@"",model.uhead?model.uhead:@"",model.unick?model.unick:@"",model.ghead?model.ghead:@"",model.gname?model.gname:@"",model.disturb];
            
            
        }
        
        NSMutableArray * dataArr = [[QCDataBase shared] queryListModel:model];

        NSInteger count = 0;
        for (QCListModel * model in dataArr) {
            count = count + [model.count integerValue];
        }
        NSLog(@"%@",[QCClassFunction getCurrentViewController]);
        
        UITabBarItem * item;
        
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCCodeViewController class]]) {
            item = [[QCClassFunction getSelectTabViewControllerWithSelected:0].tabBar.items objectAtIndex:1];

        }else {
            item = [[QCClassFunction getCurrentViewController].tabBarController.tabBar.items objectAtIndex:1];

        }

        if (count == 0) {
            item.badgeValue = nil;

        }else{
            item.badgeValue = [NSString stringWithFormat:@"%ld",count];

        }
        
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCMessageViewController class]]) {
            QCMessageViewController * messageViewController = (QCMessageViewController *)[QCClassFunction getCurrentViewController];
            
            
            [messageViewController GETDATA];
            
        }else{

        }
        
        
        
        
        [self.db  close];
        
        
        

        
    }else{
        
        
    }
    
    
}

- (void )upTopByListId:(NSString *)listId withIsTop:(NSString *)isTop{

    if ([self.db  open]) {
    
        NSString * str = [NSString stringWithFormat:@"select * from chatList where listId = '%@'",listId];
        FMResultSet * set = [self.db  executeQuery:str];

        if ([set next]) {

            [self.db  executeUpdate:@"UPDATE chatList SET isTop = ? WHERE listId = ?",isTop,listId];
  
        }
        [self.db  close];

    }
}


- (void )upDisturbByListId:(NSString *)listId withIsDisturb:(NSString *)isDisturb{

    if ([self.db  open]) {
    
        NSString * str = [NSString stringWithFormat:@"select * from chatList where listId = '%@'",listId];
        FMResultSet * set = [self.db  executeQuery:str];

        if ([set next]) {

            [self.db  executeUpdate:@"UPDATE chatList SET disturb = ? WHERE listId = ?",isDisturb,listId];
  
        }
        [self.db  close];

    }
}


-(void)removeAllListModel:(QCListModel *)model {
    
    
    if ([self.db  open]) {
        [self.db  executeUpdate:@"DELETE FROM chatList "];
        [self.db  close];
        
    }else{
        
        
    }
}

#pragma mark ----
-(void)insertAssociatedModel:(QCAssociatedModel *)model {
    
    //        NSDictionary * associatedDic = @{@"associatedId":dic[@"msgid"],@"type":dic[@"type"],@"uid":dic[@"uid"],@"rid":dic[@"touid"],@"msgid":dic[@"msgid"],@"message":dic[@"message"],@"time":dic[@"time"],@"status":@"0",@"applyid":dic[@"applyid"],@"smsid":dic[@"smsid"]};
    
    if ([self.db  open]) {
        [self.db  executeUpdate:@"INSERT INTO friendList (associatedId,type, uid, rid, msgid, message, time, status, applyid, smsid) VALUES (?,?,?,?,?,?,?,?,?);",model.associatedId,model.type,model.uid,model.rid,model.msgid,model.message,model.time,model.status,model.applyid,model.smsid];
        [self.db  close];
        
    }else{
        
    }
    
}
-(void)deleteAssociatedModel:(QCAssociatedModel *)model {
    
    
    if ([self.db  open]) {
        [self.db  executeUpdate:@"delete from friendList"];
        [self.db  close];
    }else{
        
    }
}
-(void)updateAssociatedModel:(QCAssociatedModel *)model {
    
    
    if ([self.db  open]) {
        //        [self.database executeUpdate:@"UPDATE car6 SET quantity = ?,productPrice = ?,productId = ?,productName = ?,productImg = ?,memberId = ?,productAttribute = ?,productDescription = ?,productPrice2Set = ?,productSn = ?,site = ? WHERE car6Id = ?",model.quantity,model.productPrice,model.productId,model.productName,model.productImg,model.memberId,model.productAttribute,model.productDescription,model.productPrice2Set,model.productSn,model.site,model.car6Id];
        [self.db  close];
    }else{
        
        
    }
}
-(NSMutableArray *)queryAssociatedModel:(QCAssociatedModel *)model {
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    if ([self.db  open]) {
        
        //                SELECT * FROM chat while uid|000000|tid = @"11111"
        FMResultSet *set = [self.db  executeQuery:@"SELECT * FROM friendList ORDER BY status DESC , time DESC"];
        while ([set next]) {
            model.associatedId = [set stringForColumn:@"associatedId"];
            model.type = [set stringForColumn:@"type"];
            model.uid = [set stringForColumn:@"uid"];
            model.rid = [set stringForColumn:@"rid"];
            model.msgid = [set stringForColumn:@"msgid"];
            model.message = [set stringForColumn:@"message"];
            model.time = [set stringForColumn:@"time"];
            model.status = [set stringForColumn:@"status"];
            model.applyid = [set stringForColumn:@"applyid"];
            model.smsid = [set stringForColumn:@"smsid"];
            
            [array addObject: model];
        }
        
        [self.db  close];
        
    }else{
        
        
    }
    
    NSLog(@"%ld",array.count);
    
    return array;
}



- (void )queryByAssociatedId:(QCAssociatedModel *)model {
    
    
    if ([self.db  open]) {
        
        
        NSString * str = [NSString stringWithFormat:@"select * from friendList where associatedId = '%@'",model.associatedId];
        FMResultSet * set = [self.db  executeQuery:str];
        
        if ([set next]) {
            
            
            [self.db  executeUpdate:@"UPDATE friendList SET time = ? ,status = ?  WHERE associatedId = ?",model.time,model.status,model.associatedId];
            
            NSLog(@"1");
            
            
        }else{
            //  没有数据添加数据
            
            
            [self.db  executeUpdate:@"INSERT INTO friendList (associatedId,type, uid, rid, msgid, message, time, status, applyid, smsid) VALUES (?,?,?,?,?,?,?,?,?,?);",model.associatedId,model.type,model.uid,model.rid,model.msgid,model.message,model.time,model.status,model.applyid,model.smsid];
        }
        
        
        
        NSArray * arr = [[QCDataBase shared] queryAssociatedModel:model];
        
        UITabBarItem * item = [[QCClassFunction getCurrentViewController].tabBarController.tabBar.items objectAtIndex:2];
        if (arr.count == 0) {
            item.badgeValue = nil;

        }else{
            [item setBadgeValue:[NSString stringWithFormat:@"%ld",arr.count]];
            
            if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCBookViewController class]]) {
                QCBookViewController * bookViewController = (QCBookViewController *)[QCClassFunction getCurrentViewController];
                
                
                [bookViewController GETDATA];
                
            }else{

            }
            
        }
        
        
        [self.db  close];
        
    }else{
        
        
    }
    
    
}


-(void)removeAllAssociatedModel:(QCAssociatedModel *)model {
    
    
    if ([self.db  open]) {
        [self.db  executeUpdate:@"DELETE FROM friendList"];
        [self.db  close];
        
    }else{
        
        
    }
}




@end

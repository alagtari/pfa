from typing import Optional
from fastapi import FastAPI
from datetime import date,datetime,time
from fastapi.middleware import Middleware
from fastapi.middleware.cors import CORSMiddleware
from dateutil.relativedelta import relativedelta

import mysql.connector



origins = ["*"]
middleware = [ Middleware(CORSMiddleware, allow_origins=['*'], allow_credentials=True, allow_methods=['*'], allow_headers=['*'])]


app = FastAPI(middleware=middleware)



@app.get("/login")
def login(mail:str,pwd:str ):
    db = mysql.connector.connect(host = "localhost" , user = "root" , password = "" , database = "serenity")
    cursor = db.cursor()
    cursor.execute(f"select mail,password from user where mail = '{mail}' and password = '{pwd}'")
    print(cursor.fetchall() , cursor.rowcount)
    if( cursor.rowcount ) : 
      return {"login" : True }
    else :
      return{"login" : False }
    

@app.get("/signup")
def signup(mail:str, name:str, password:str ):
    db = mysql.connector.connect(host = "localhost" , user = "root" , password = "" , database = "serenity")
    cursor = db.cursor()
    sql ="INSERT INTO user VALUES (%s,%s,%s)"
    val =  (mail, name,  password)
    cursor.execute(sql,val)
    db.commit()
    if(cursor.rowcount == 1) :
      return {"signup" : True}
    else:
      return{"signup" : False}

@app.get("/conversations")
def conversations(mail:str):
    db = mysql.connector.connect(host = "localhost" , user = "root" , password = "" , database = "serenity")
    cursor = db.cursor()
    cursor.execute(f"select * from Conversation where mail1 = '{mail}' or mail2 = '{mail}'")
    rv = cursor.fetchall()
    cursor.close
    resultat =[]
    for item in rv :
        Nitem = [(i) for i in item if i != mail]
        resultat.append(Nitem)
    for item in resultat :
      cursor.execute(f"select name from user where mail = '{item[1]}'")
      rv = cursor.fetchall()
      item.append(rv[0][0])
      cursor.execute(f"select msg,date,time from message where id_conv = '{item[0]}' order by id_msg desc")
      rv1 = cursor.fetchall() 
      item.pop(1)
      if len(rv1) == 0 :
          item.append('Now you can send a message')
          item.append('not yet')
      else :
            item.append(rv1[0][0])
            msg_date = str(rv1[0][1])
            msg_time = str(rv1[0][2])
            msgdate = datetime(int(msg_date[0:4]),int(msg_date[5:7]),int(msg_date[8:10]),int(msg_time[-8:-6]),int(msg_time[-5:-3]),int(msg_time[-2:]))
            if relativedelta(datetime.now(),msgdate).years == 0:
                if (datetime.now()-msgdate).days == 1:
                    date = 'yesterday'
                elif (datetime.now()-msgdate).days == 0 :
                    if (datetime.now()-msgdate).total_seconds() < 60 :
                       date = 'now'
                    else:
                       date = str(msgdate.strftime('%H:%M') )     
                else :  
                    date = str(msgdate.strftime('%d %b')) 
            else :
                date = str(msgdate.strftime('%d %b %Y')) 
            item.append(date) 
                    
    return resultat



@app.get("/conversation")
def conversation(mail:str ,id_conv:int):
    db = mysql.connector.connect(host = "localhost" , user = "root" , password = "" , database = "serenity")
    cursor = db.cursor()
    cursor.execute(f"select * from message where id_conv = '{id_conv}'")
    rv = cursor.fetchall()
    resultat =[]
    
    for item in rv :
        msg_date = str(item[-2])
        msg_time = str(item[-1])
        msgdate = datetime(int(msg_date[0:4]),int(msg_date[5:7]),int(msg_date[8:10]),int(msg_time[-8:-6]),int(msg_time[-5:-3]),int(msg_time[-2:]))
        if relativedelta(datetime.now(),msgdate).years == 0:
            if (datetime.now()-msgdate).days == 1:
                date = 'yesterday'
            elif (datetime.now()-msgdate).days == 0 :
                if (datetime.now()-msgdate).total_seconds() < 60 :
                   date = 'now'
                else:
                   date = str(msgdate.strftime('%H:%M') )   
                      
                    
            else :  
                date = str(msgdate.strftime('%d %b')) 
        else :
            date = str(msgdate.strftime('%d %b %Y')) 
               
        print(date)
        Nitem = []
        Nitem.append(item[2]) 
        if item[3] != mail :
            Nitem.append(False)
        else :
            Nitem.append(True)
        Nitem.append(date)
        resultat.append(Nitem)
        del Nitem
    return resultat

@app.get("/sendMsg")
def sendmsg(mail:str,id_conv :int,msg:str,):
    db = mysql.connector.connect(host = "localhost" , user = "root" , password = "" , database = "serenity")
    cursor = db.cursor()
    day = date.today()
    time = datetime.now()

    current_time = time.strftime("%H:%M")
    print(current_time)
    sql ="INSERT INTO message VALUES (null,%s,%s,%s,%s,%s)"
    val =  (id_conv,msg, mail,day,current_time)
    cursor.execute(sql,val)
    db.commit()
    if(cursor.rowcount == 1) :
      return {"sended" : True}
    else:
      return{"sended" : False}    


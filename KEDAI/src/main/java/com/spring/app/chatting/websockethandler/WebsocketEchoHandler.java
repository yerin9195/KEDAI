package com.spring.app.chatting.websockethandler;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.app.domain.MemberVO;



//==== #226. (웹채팅관련8) ==== //
//@Component // 은 이미 /board/src/main/webapp/WEB-INF/spring/config/websocketContext.xml 파일에서 bean 으로 등록을 해주었으므로 할 필요가 없음.!!
public class WebsocketEchoHandler extends TextWebSocketHandler {
	
	// === 웹소켓서버에 연결한 클라이언트 사용자들을 저장하는 리스트 ===
	private List<WebSocketSession> connectedUsers = new ArrayList<>();
	
	// ====== 몽고 DB 시작 ========= //
	// =======#234. 웹채팅관련16 ====//
	@Autowired
	private ChattingMongoOperations chattingMongo;
	
	@Autowired
	private Mongo_messageVO dto;
	
	
	// ========== 몽고 DB 끝 ============================//
	public void init() throws Exception {}
	
	// === 클라이언트가 웹소켓서버에 연결했을때의 작업 처리하기 ===
    /*
       afterConnectionEstablished(WebSocketSession wsession) 메소드는 
              클라이언트가 웹소켓서버에 연결이 되어지면 자동으로 실행되는 메소드로서
       WebSocket 연결이 열리고 사용이 준비될 때 호출되어지는(실행되어지는) 메소드이다.
    */
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession wsession) throws Exception { 
	   // >>> 파라미터 WebSocketSession wsession 은 웹소켓서버에 접속한 클라이언트 사용자임. <<< 
	   // 웹소켓서버에 접속한 클라이언트의 IP Address 얻어오기
       /*
         STS 메뉴의 
         Run --> Run Configuration 
             --> Arguments 탭
             --> VM arguments 속에 맨 뒤에
             --> 한칸 띄우고 -Djava.net.preferIPv4Stack=true 
                         을 추가한다.  
       */
		System.out.println("=====> 웹 채팅확인용 : " + wsession.getId() + "님이 접속했습니다.");
		
		
		System.out.println("====> 웹채팅확인용 : " + "연결 컴퓨터명 : " + wsession.getRemoteAddress().getHostName());
		
		System.out.println("====> 웹채팅확인용 : " + "연결 컴퓨터명 : " + wsession.getRemoteAddress().getAddress().getHostName());
		
		
		System.out.println("====> 웹채팅확인용 : " + "연결 IP : " + wsession.getRemoteAddress().getAddress().getHostAddress());
	
		
		connectedUsers.add(wsession);
		
		///// ===== 웹소켓 서버에 접속시 접속자명단을 알려주기 위한 것 시작 ===== /////
        // Spring에서 WebSocket 사용시 먼저 HttpSession에 저장된 값들을 읽어와서 사용하기
	       
		/*
	              먼저 /webapp/WEB-INF/spring/config/websocketContext.xml 파일에서
          websocket:handlers 태그안에 websocket:handshake-interceptors에
          HttpSessionHandshakeInterceptor를 추가하면 WebsocketEchoHandler 클래스를 사용하기 전에 
                      먼저 HttpSession에 저장되어진 값들을 읽어 들여 WebsocketEchoHandler 클래스에서 사용할 수 있도록 처리해준다. 
	    */
		
		String connectingUserName = "「";  //「 은  자음 ㄴ 을 하면 나온다.
		
		for(WebSocketSession webSocketSession: connectedUsers) {
			Map<String,Object> map = webSocketSession.getAttributes();
		 /*
            webSocketSession.getAttributes(); 은 
            HttpSession에 setAttribute("키",오브젝트); 되어 저장되어진 값들을 읽어오는 것으로써,
                          리턴값은  "키",오브젝트로 이루어진 Map<String, Object> 으로 받아온다.
         */
			
		  MemberVO loginuser = (MemberVO)map.get("loginuser");	
		  // "loginuser" 은 HttpSession에 저장된 키 값으로 로그인 되어진 사용자이다.
			
		  connectingUserName += loginuser.getName()+" ";
		  
			
			
		}// end of for()----------------------------------------------------
		
		connectingUserName += "」 ";
		System.out.println("확인용 connectingUserName : " + connectingUserName);
		// 확인용 connectingUserName : 「유선우 」 
		
		
		for(WebSocketSession webSocketSession : connectedUsers) {
			webSocketSession.sendMessage(new TextMessage(connectingUserName));
			
		}// end of for()----------------------------------------
		
		
		///// ===== 웹소켓 서버에 접속시 접속자명단을 알려주기 위한 것 끝 ===== /////
		
		
		// ============ 몽고 DB시작 ===============================//
		List<Mongo_messageVO> list = chattingMongo.listChatting(); // 몽고DB에 저장되어진 채팅내용을 읽어온다.
        
        SimpleDateFormat sdfrmt = new SimpleDateFormat("yyyy년 MM월 dd일 E요일", Locale.KOREAN);
        
        if(list != null && list.size() > 0) { // 이전에 나누었던 대화내용이 있다라면 
           for(int i=0; i<list.size(); i++) {
              
              String str_created = sdfrmt.format(list.get(i).getCreated());  // 대화내용을 나누었던 날짜를 읽어온다. 2024년 05월 09일 목요일
              
              System.out.println(list.get(i).getEmpid() + "\n"
                                   + list.get(i).getName() + "\n"
                                   + list.get(i).getCurrentTime() + "\n"
                                   + list.get(i).getMessage() + "\n"
                                   + list.get(i).getCreated() + "\n"
                                   + str_created + "\n"
                                   + list.get(i).getCurrentTime() + "\n" );
	              
	     // }// end of for-----------------------------------
		
         //   System.out.println("=================================\n");
		
              boolean is_newDay = true; // 대화내용의 날짜가 같은 날짜인지 새로운 날짜인지 알기위한 용도임.
              
              if( i > 0 && str_created.equals( sdfrmt.format(list.get(i-1).getCreated()) )  ) {  // 다음번 내용물에 있는 대화를 했던 날짜가 이전 내용물에 있는 대화를 했던 날짜와 같다라면  
                 is_newDay = false; // 이 대화내용은 새로운 날짜의 대화가 아님을 표시한다.        
              }
              
              if(is_newDay) {     
                 wsession.sendMessage(
                	new TextMessage("<div style='text-align: center; background-color: #ccc;'>" + str_created + "</div>")  
                ); // 대화를 나누었던 날짜를 배경색을 회색으로 하여 보여주도록 한다.
              }
                 
              Map<String, Object> map = wsession.getAttributes();
               /*
                  wsession.getAttributes(); 은 
                  HttpSession에 setAttribute("키",오브젝트); 되어 저장되어진 값들을 읽어오는 것으로써,
                                       리턴값은  "키",오브젝트로 이루어진 Map<String, Object> 으로 받아온다.
               */ 
               
              MemberVO loginuser = (MemberVO)map.get("loginuser");  
              // "loginuser" 은 HttpSession에 저장된 키 값으로 로그인 되어진 사용자이다.
                       
              if(loginuser.getEmpid().equals(list.get(i).getEmpid())) { // 본인이 작성한 채팅메시지일 경우라면.. 작성자명 없이 노랑배경색에 오른쪽 정렬로 보이게 한다.
                 if("all".equals(list.get(i).getType())) { // 귀속말이 아닌 경우
                    wsession.sendMessage(
                    	new TextMessage("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'>" + list.get(i).getMessage() + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+list.get(i).getCurrentTime()+"</div> <div style='clear: both;'>&nbsp;</div>")  
                    ); 
                 }
                 else { // 귀속말인 경우. 글자색을 빨강색으로 함.
                    wsession.sendMessage(
                    	new TextMessage("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all; color: red;'>" + list.get(i).getMessage() + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+list.get(i).getCurrentTime()+"</div> <div style='clear: both;'>&nbsp;</div>")  
                    );
                 }
              }
              
              else { // 다른 사람이 작성한 채팅메시지일 경우라면.. 작성자명이 나오고 흰배경색으로 보이게 한다.
                  if("all".equals(list.get(i).getType())) { // 귀속말이 아닌 경우
                     wsession.sendMessage(
                     	new TextMessage("[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>" +list.get(i).getName()+ "</span>]<br><div style='background-color: white; display: inline-block; max-width: 60%; padding: 7px; border-radius: 15%; word-break: break-all;'>"+ list.get(i).getMessage() +"</div> <div style='display: inline-block; padding: 20px 0 0 5px; font-size: 7pt;'>"+list.get(i).getCurrentTime()+"</div> <div>&nbsp;</div>" ) 
                     );
                  }
                  else { // 귀속말인 경우. 글자색을 빨강색으로 함.
                     wsession.sendMessage(
                     	new TextMessage("[<span style='font-weight:bold; cursor:pointer;' class='loginuserName'>" +list.get(i).getName()+ "</span>]<br><div style='background-color: white; display: inline-block; max-width: 60%; padding: 7px; border-radius: 15%; word-break: break-all; color: red;'>"+ list.get(i).getMessage() +"</div> <div style='display: inline-block; padding: 20px 0 0 5px; font-size: 7pt;'>"+list.get(i).getCurrentTime()+"</div> <div>&nbsp;</div>" ) 
                     );
                  }
               }
               
             }// end of for-----------------------------------     
           
        	}// end of if if(list != null && list.size() > 0)-------------------------------------     
        
		// ============ 몽고 DB끝 ===============================//
    
	}
	
	// === 클라이언트가 웹소켓 서버로 메시지를 보냈을때의 Send 이벤트를 처리하기 ===
    /*
       handleTextMessage(WebSocketSession wsession, TextMessage message) 메소드는 
                 클라이언트가 웹소켓서버로 메시지를 전송했을 때 자동으로 호출되는(실행되는) 메소드이다.
                 첫번째 파라미터  WebSocketSession 은  메시지를 보낸 클라이언트임.
              두번째 파라미터  TextMessage 은  메시지의 내용임.
    */
	
	@Override
    public void handleTextMessage(WebSocketSession wsession, TextMessage message) throws Exception { 
     
	  // >>> 파라미터 WebSocketSession wsession은  웹소켓서버에 접속한 클라이언트임. <<<
	  // >>> 파라미터 TextMessage message 은  클라이언트 사용자가 웹소켓서버로 보낸 웹소켓 메시지임. <<<
      
	   // Spring에서 WebSocket 사용시 먼저 HttpSession에 저장된 값들을 읽어와서 사용하기
	   /*
	          먼저 /webapp/WEB-INF/spring/config/websocketContext.xml 파일에서
	      websocket:handlers 태그안에 websocket:handshake-interceptors에
	        HttpSessionHandshakeInterceptor를 추가해주면 
	        WebSocketHandler 클래스를 사용하기 전에, 
	                 먼저 HttpSession에 저장되어진 값들을 읽어 들여, WebSocketHandler 클래스에서 사용할 수 있도록 처리해준다. 
	    */
     
     Map<String, Object> map = wsession.getAttributes(); 
     MemberVO loginuser = (MemberVO) map.get("loginuser");
     // "loginuser" 은 HttpSession에 저장된 키 값으로 로그인 되어진 사용자이다.
     System.out.println("===> 웹채팅확인용 : 로그인ID : " + loginuser.getEmpid());
     
     //    System.out.println("===> 웹채팅확인용 : 로그인ID : " + loginuser.getEmpid());
     // ===> 웹채팅확인용 : 로그인ID : seoyh 
	
	
	
	
	}
	
}

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <meta charset="UTF-8">
  <title>예약 상세 정보</title>
  <style>
      body {
          font-family: Arial, sans-serif;
      }
      .container_resercation_detail {
          width: 80%;
          margin: auto;
          padding: 20px;
          border: 1px solid #ddd;
          border-radius: 5px;
          background-color: #f9f9f9;
          margin-top: 1%;
      }
      h1 {
          text-align: center;
          margin-bottom: 20px;
      }
      .details {
          margin-bottom: 20px;
      }
      .details div {
          margin-bottom: 10px;
      }
      .buttons {
          text-align: center;
      }
      .buttons a {
          display: inline-block;
          margin: 5px;
          padding: 10px 20px;
          font-size: 16px;
          text-decoration: none;
          color: #fff;
          background-color: #007bff;
          border-radius: 5px;
      }
      .buttons a.edit {
          background-color: #28a745;
      }
      .buttons a.cancel {
          background-color: #dc3545;
      }
      .buttons a.back {
          background-color: #6c757d;
      }
  </style>

<body>
    <div class="container_resercation_detail">
    	<h1>예약 상세 정보</h1>
        <div class="details">
		    <c:if test="${empty reservations}">
			    <p>예약 정보가 없습니다.</p>
			</c:if>
			<c:forEach var="reservation" items="${reservations}">
			    <div><strong>예약 ID:</strong> ${reservation.reservation_seq}</div>
			    <div><strong>회의실:</strong> ${reservation.roomName}</div>
			    <div><strong>예약자:</strong> ${reservation.reserver}</div>
			    <div><strong>시작 시간:</strong> ${reservation.startTime}</div>
			    <div><strong>종료 시간:</strong> ${reservation.endTime}</div>
			    <div><strong>목적:</strong> ${reservation.purpose}</div>
			    <div><strong>상태:</strong> ${reservation.status}</div>
			    <hr/>
			</c:forEach>
		</div>
		
		 <div class="buttons">
            <a href="<%= request.getContextPath() %>/roomResercation.kedai" class="back">목록으로 돌아가기</a>
            <a href="<%= request.getContextPath() %>/edit_reservation.kedail?id=${reservation_seq}" class="edit">예약 수정하기</a>
            <a href="<%= request.getContextPath() %>/cancel_reservation.kedail?id=${reservation_seq}" class="cancel">예약 취소하기</a>
        </div>
        
    </div>
</body>
</html>

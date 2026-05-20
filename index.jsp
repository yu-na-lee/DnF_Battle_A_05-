<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="rpg.전투" %>
<%
    // POST 요청 시 한글 깨짐 방지
    request.setCharacterEncoding("UTF-8");

    // 세션(Session)을 이용해 '전투' 객체를 유지 (캐릭터 상태 보존)
    전투 전 = (전투) session.getAttribute("battleSystem");
    if (전 == null) {
        전 = new 전투();
        session.setAttribute("battleSystem", 전);
    }

    String action = request.getParameter("action");
    String resultMessage = "";

    // 액션 분기 처리
    if ("create".equals(action)) {
        String playerId = request.getParameter("playerId");
        String charName = request.getParameter("charName");
        int level = Integer.parseInt(request.getParameter("level"));
        String job = request.getParameter("job");
        
        resultMessage = 전.캐릭터생성(playerId, charName, level, job);
        
    } else if ("attack".equals(action)) {
        String playerId = request.getParameter("playerId");
        resultMessage = 전.몬스터공격(playerId);
        
    } else if ("reset".equals(action)) {
        session.invalidate(); // 초기화
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RPG 캐릭터 시스템</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; }
    .box { border: 1px solid #ccc; padding: 20px; margin-bottom: 20px; border-radius: 5px; width: 400px; background-color: #f9f9f9; }
    .result { border: 2px solid #4CAF50; padding: 15px; width: 400px; background-color: #e8f5e9; border-radius: 5px; }
    input, select, button { margin-top: 5px; padding: 5px; width: 100%; box-sizing: border-box; }
    label { font-weight: bold; font-size: 14px; }
</style>
</head>
<body>

    <h2>RPG 캐릭터 생성 및 전투</h2>

    <!-- 캐릭터 생성 UI (Create_Character_UI 역할) -->
    <div class="box">
        <h3>1. 캐릭터 생성</h3>
        <form method="post" action="index.jsp">
            <input type="hidden" name="action" value="create">
            
            <label>플레이어 ID (hero 입력 필수):</label>
            <input type="text" name="playerId" required><br><br>
            
            <label>캐릭터명:</label>
            <input type="text" name="charName" required><br><br>
            
            <label>레벨:</label>
            <input type="number" name="level" min="1" value="1" required><br><br>
            
            <label>직업:</label>
            <select name="job">
                <option value="전사">전사</option>
                <option value="마법사">마법사</option>
            </select><br><br>
            
            <button type="submit">캐릭터 생성</button>
        </form>
    </div>

    <!-- 몬스터 공격 UI (Attack_Monster_UI 역할) -->
    <div class="box">
        <h3>2. 몬스터 공격</h3>
        <form method="post" action="index.jsp">
            <input type="hidden" name="action" value="attack">
            <label>플레이어 ID 인증:</label>
            <input type="text" name="playerId" required placeholder="hero를 입력하세요"><br><br>
            
            <button type="submit" style="background-color: #ff9800; color: white; border: none; font-weight: bold;">공격하기!</button>
        </form>
    </div>

    <!-- 처리 결과 출력 -->
    <% if (!resultMessage.isEmpty()) { %>
        <div class="result">
            <h4>[ 실행 결과 ]</h4>
            <p><%= resultMessage %></p>
        </div>
    <% } %>

    <br>
    <form method="post" action="index.jsp" style="width: 440px;">
        <input type="hidden" name="action" value="reset">
        <button type="submit" style="background-color: #f44336; color: white; border: none;">초기화 (새로 시작)</button>
    </form>

</body>
</html>
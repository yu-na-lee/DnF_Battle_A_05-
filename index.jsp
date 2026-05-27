<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="rpg.전투" %>
<%
    request.setCharacterEncoding("UTF-8");

    전투 전 = (전투) session.getAttribute("battleSystem");
    if (전 == null) {
        전 = new 전투();
        session.setAttribute("battleSystem", 전);
    }

    String action = request.getParameter("action");
    String resultMessage = "";

    if ("create".equals(action)) {
        String playerId = request.getParameter("playerId");
        String charName = request.getParameter("charName");
        int level = Integer.parseInt(request.getParameter("level"));
        String job = request.getParameter("job");
        전.캐릭터생성(playerId, charName, level, job);
        resultMessage = 전.get마지막결과메시지();

    } else if ("attack".equals(action)) {
        String playerId = request.getParameter("playerId");
        전.몬스터공격(playerId);
        resultMessage = 전.get마지막결과메시지();

    } else if ("addItem".equals(action)) {
        String playerId = request.getParameter("playerId");
        String itemName = request.getParameter("itemName");
        String itemType = request.getParameter("itemType");
        int itemValue = Integer.parseInt(request.getParameter("itemValue"));
        전.아이템획득(playerId, itemName, itemType, itemValue);
        resultMessage = 전.get마지막결과메시지();

    } else if ("joinGuild".equals(action)) {
        String playerId = request.getParameter("playerId");
        String guildName = request.getParameter("guildName");
        전.길드가입(playerId, guildName);
        resultMessage = 전.get마지막결과메시지();

    } else if ("reset".equals(action)) {
        session.invalidate();
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
    .result { border: 2px solid #4CAF50; padding: 15px; width: 400px; background-color: #e8f5e9; border-radius: 5px; white-space: pre-line; }
    input, select, button { margin-top: 5px; padding: 5px; width: 100%; box-sizing: border-box; }
    label { font-weight: bold; font-size: 14px; }
</style>
</head>
<body>

    <h2>RPG 캐릭터 생성 및 전투</h2>

    <div class="box">
        <h3>1. 캐릭터 생성 (Create_Character_UI)</h3>
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

    <div class="box">
        <h3>2. 몬스터 공격 (Attack_Monster_UI)</h3>
        <form method="post" action="index.jsp">
            <input type="hidden" name="action" value="attack">
            <label>플레이어 ID 인증:</label>
            <input type="text" name="playerId" required placeholder="hero를 입력하세요"><br><br>
            <button type="submit" style="background-color: #ff9800; color: white; border: none; font-weight: bold;">공격하기!</button>
        </form>
    </div>

    <div class="box">
        <h3>3. 아이템 획득 (Add_Item_UI)</h3>
        <form method="post" action="index.jsp">
            <input type="hidden" name="action" value="addItem">
            <label>플레이어 ID (hero):</label>
            <input type="text" name="playerId" required placeholder="hero"><br><br>
            <label>아이템명:</label>
            <input type="text" name="itemName" required><br><br>
            <label>아이템 타입:</label>
            <select name="itemType">
                <option value="무기">무기</option>
                <option value="방어구">방어구</option>
                <option value="물약">물약</option>
            </select><br><br>
            <label>아이템 가치 (등급: 1000+ 전설, 500+ 희귀, 500 미만 일반):</label>
            <input type="number" name="itemValue" min="0" value="100" required><br><br>
            <button type="submit" style="background-color: #2196F3; color: white; border: none; font-weight: bold;">아이템 획득</button>
        </form>
    </div>

    <div class="box">
        <h3>4. 길드 가입 (Join_Guild_UI)</h3>
        <form method="post" action="index.jsp">
            <input type="hidden" name="action" value="joinGuild">
            <label>플레이어 ID (hero):</label>
            <input type="text" name="playerId" required placeholder="hero"><br><br>
            <label>길드명:</label>
            <input type="text" name="guildName" required placeholder="모험가연합 또는 던전공격대"><br><br>
            <button type="submit" style="background-color: #9C27B0; color: white; border: none; font-weight: bold;">길드 가입</button>
        </form>
        <p style="font-size: 12px; color: #666;">※ 가입 가능 길드: 모험가연합, 던전공격대 (사전 생성된 길드만 가입 가능)</p>
        <p style="font-size: 12px; color: #666;">※ 길드 최대 인원 5명. 정원 초과 시 가입 불가.</p>
    </div>

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

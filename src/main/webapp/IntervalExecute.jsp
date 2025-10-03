<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.util.List" %>
<%@ page import = "bean.ShopBean" %>
<%
	// Servletのデータ受け取り
	request.setCharacterEncoding("UTF8");
	//ry{
	// リクエストオブジェクトに設定されたBEANを取得
		List<ShopBean> shopBeanList = (List<ShopBean>)request.getAttribute("shopBeanList");
	//}catch{
	//	System.err.println("店舗情報が取得できませんでした。");
	//}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>行きたい店舗ランダム選択ツール</title>
     <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tbody tr:hover {
            background-color: #f5f5f5;
        }
        .selected {
            background-color: #ffeb3b !important;
            font-weight: bold;
            animation: highlight 0.5s ease;
        }
        @keyframes highlight {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
        .result-box {
            margin: 20px 0;
            padding: 20px;
            border: 2px solid #4CAF50;
            border-radius: 8px;
            background-color: #e8f5e9;
            display: none;
            text-align: center;
        }
        .result-box.show {
            display: block;
            animation: fadeIn 0.5s ease;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .result-box h3 {
            margin-top: 0;
            color: #2e7d32;
        }
        .btn-container {
            margin: 20px 0;
            text-align: center;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        .btn:hover {
            background-color: #45a049;
            transform: scale(1.05);
        }
        .btn:active {
            transform: scale(0.95);
        }
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
        <c:choose>
            <c:when test="${empty shopBeanList}">
                <div class="empty-message">
                    <p>表示するユーザーがいません</p>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 一覧テーブル -->
                <table id="shopTable">
                    <thead>
                        <tr>
                            <th>店舗名</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="shop" items="${shopBeanList}" varStatus="status">
                            <tr id="row-${status.index}" 
                                data-name="${shop.name}" 
                                <!-- data-name="${user.name}" 
                                data-email="${user.email}"> -->
                                <td>${shop.name}</td>
                                <!-- <td>${user.name}</td>
                                <td>${user.email}</td>
                                <td>${user.registrationDate}</td>-->
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <!-- 結果表示エリア -->
                <div id="resultBox" class="result-box">
                    <h3>🎯 選ばれたのは...</h3>
                    <p id="resultText" style="font-size: 18px; margin: 10px 0;"></p>
                </div>
                
                <!-- ランダム選択ボタン -->
                <div class="btn-container">
                    <button type="button" class="btn" onclick="selectRandomUser()">
                        🎲 ランダムに選択
                    </button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- 結果表示エリア -->
    <div id="resultBox" class="result-box">
        <h3>🎯 選ばれたのは...</h3>
        <p id="resultText"></p>
    </div>
    
    <script>
        function selectRandomUser() {
            const table = document.getElementById('shopTable');
            const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
            
            // 一覧が空の場合
            if (rows.length === 0) {
                alert('選択できる店舗がありません');
                return;
            }
            
            // 以前の選択をクリア
            for (let i = 0; i < rows.length; i++) {
                rows[i].classList.remove('selected');
            }
            
            // ランダムに行を選択
            const randomIndex = Math.floor(Math.random() * rows.length);
            const selectedRow = rows[randomIndex];
            
            // 選択された行をハイライト
            selectedRow.classList.add('selected');
            
            // 選択された行のデータを取得
            const shop = selectedRow.getAttribute('data-name');
            
            // 結果を表示
            const resultBox = document.getElementById('resultBox');
            const resultText = document.getElementById('resultText');
            resultText.innerHTML = `<strong>決定したのは。。。</strong> (店舗名: ${shop})<br>です！`;
            resultBox.classList.add('show');
            
            // 選択された行までスクロール
            selectedRow.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    </script>
</body>
</html>
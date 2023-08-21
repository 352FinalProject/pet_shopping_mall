<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
    <title>검색 팝업</title>
</head>
<body>
    <form action="/member/search" method="get">
        <label for="id">검색할 ID:</label>
        <input type="text" id="id" name="id" required>
        <button type="submit">검색</button>
    </form>
</body>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 요약보기 | PickMe Cup</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/style.css" rel="stylesheet">

    <!-- favicon -->
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/static/favicon/favicon-96x96.png"
          sizes="96x96"/>
    <link rel="icon" type="image/svg+xml" href="<%= request.getContextPath() %>/static/favicon/favicon.svg"/>
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/static/favicon/favicon.ico"/>
    <link rel="apple-touch-icon" sizes="180x180"
          href="<%= request.getContextPath() %>/static/favicon/apple-touch-icon.png"/>
    <link rel="manifest" href="<%= request.getContextPath() %>/static/favicon/site.webmanifest"/>

    <!-- OG -->
    <meta name="description" content="PickMe Cup - 당신의 최애를 찾아보세요!">
    <meta property="og:title" content="PickMe Cup - 이상형 월드컵">
    <meta property="og:description" content="당신의 최애를 찾아보세요!">
    <meta property="og:image" content="<%= request.getContextPath() %>/static/logo/og.png">
    <meta property="og:type" content="website">
    <meta property="og:site_name" content="PickMe Cup">

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white fixed-top">
    <div class="container">
        <a class="navbar-brand" href="./">
            <img src="<%= request.getContextPath() %>/static/logo/topbar.png" alt="PickMe Cup">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <%-- 메뉴 항목 생략 --%>
            </ul>
            <%--            <div class="d-flex ms-3">--%>
            <%--                <button class="btn btn-outline-danger" type="button">로그인</button>--%>
            <%--            </div>--%>
        </div>
    </div>
</nav>

<div class="footer">
    <p>© 2025 이상형 월드컵. All rights reserved.</p>
</div>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이상형 선택 | PickMe Cup</title>
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

    <!-- Bootstrap & 필요한 JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <!-- YouTube API 스크립트 -->
    <script src="https://www.youtube.com/iframe_api"></script>

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
        </div>
    </div>
</nav>

<!-- 로딩 스피너 -->
<div id="spinner">
    <div class="spinner-border text-dark" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
    <span>Loading...</span>
</div>

<!-- 게임 컨테이너 -->
<div class="container game-container" style="display: none;">
    <div class="game-header">
        <h1 class="game-title"></h1>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="vs-container">
                <!-- 첫 번째 아이템 -->
                <div class="item-card" data-index="0">
                    <!-- YouTube 플레이어 컨테이너 -->
                    <div class="video-container youtube-container">
                        <iframe class="youtube-player"
                                src="https://www.youtube.com/embed/?enablejsapi=1"
                                frameborder="0"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                allowfullscreen></iframe>
                        <div class="item-info">
                            <h5 class="item-title"></h5>
                        </div>
                    </div>
                    <!-- 이미지 컨테이너 -->
                    <div class="image-container" style="display: none;">
                        <img src="" alt="이미지" class="img-fluid rounded">
                        <div class="item-info">
                            <h5 class="item-title"></h5>
                        </div>
                    </div>
                    <button class="select-button">선택하기</button>
                </div>

                <div class="d-none d-lg-block">
                    <div class="vs-badge">VS</div>
                </div>
                <div class="d-block d-lg-none">
                    <div class="vs-badge">VS</div>
                </div>

                <!-- 두 번째 아이템 -->
                <div class="item-card" data-index="1">
                    <!-- YouTube 플레이어 컨테이너 -->
                    <div class="video-container youtube-container">
                        <iframe class="youtube-player"
                                src="https://www.youtube.com/embed/?enablejsapi=1"
                                frameborder="0"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                allowfullscreen></iframe>
                        <div class="item-info">
                            <h5 class="item-title"></h5>
                        </div>
                    </div>
                    <!-- 이미지 컨테이너 -->
                    <div class="image-container" style="display: none;">
                        <img src="" alt="이미지" class="img-fluid rounded">
                        <div class="item-info">
                            <h5 class="item-title"></h5>
                        </div>
                    </div>
                    <button class="select-button">선택하기</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 진행바 영역 -->
    <div class="progress-container">
        <div class="progress">
            <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0"
                 aria-valuemax="100"></div>
        </div>
        <p class="progress-text">0/8 진행 중 (총 16강)</p>
    </div>
</div>

<!-- 결과 모달 (게임 완료 후 표시) -->
<div class="modal fade" id="resultModal" tabindex="-1" aria-labelledby="resultModalLabel" aria-hidden="true"
     data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="resultModalLabel">🏆 우승자 발표!</h5>
                <button type="button" class="btn-close modal-close" data-bs-dismiss="modal" aria-label="Close"
                        onclick="location.href = `/`"></button>
            </div>
            <div class="modal-body text-center">
                <h3 class="mb-3">당신의 이상형은</h3>
                <div class="winner-container mb-3">
                    <!-- YouTube 플레이어 결과 -->
                    <div class="video-container winner-youtube-container mb-3" style="padding-bottom: 56.25%;">
                        <iframe class="winner-youtube-player"
                                src="https://www.youtube.com/embed/?enablejsapi=1" title="Loading..."
                                frameborder="0"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                allowfullscreen></iframe>
                    </div>
                    <!-- 이미지 결과 -->
                    <div class="winner-image-container mb-3" style="display: none;">
                        <img src="" alt="우승 이미지" class="img-fluid rounded">
                    </div>
                    <h4 class="winner-title" style="white-space: normal;"></h4>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button class="btn btn-style me-2" id="resultBtn" style="background-color: #535353">메인으로 돌아가기</button>
                <button class="btn btn-style" id="restartBtn">다시 플레이</button>
            </div>
        </div>
    </div>
</div>
<script src="<%= request.getContextPath() %>/static/js/worldcup.js"></script>
<div class="footer">
    <p>© 2025 이상형 월드컵. All rights reserved.</p>
</div>
</body>
</html>
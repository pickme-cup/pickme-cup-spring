<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 카테고리 생성 | PickMe Cup</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/style.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/static/css/category-create.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@ffmpeg/ffmpeg@0.10.0/dist/ffmpeg.min.js"></script>

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
    </div>
</nav>

<!-- 로딩 오버레이 -->
<div id="loadingOverlay">
    <div class="spinner-border text-light" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<div class="container game-container" style="padding-top:80px;">
    <div class="col-lg-12">
        <div class="card p-4 shadow">
            <h3 class="text-center mb-4">새 카테고리 생성</h3>
            <form action="" method="post" enctype="multipart/form-data" id="categoryForm">
                <div class="mb-3">
                    <label for="theme" class="form-label">카테고리 테마</label>
                    <input type="text" class="form-control" id="theme" name="theme" required>
                </div>
                <div class="mb-3">
                    <label for="itemType" class="form-label">아이템 타입</label>
                    <select class="form-select" id="itemType" name="itemType" required>
                        <option value="YOUTUBE">유튜브</option>
                        <option value="IMAGE">이미지</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">대표 이미지 업로드</label>
                    <div class="theme-image-container">
                        <div id="themeImagePreview">
                            <img src="" alt="대표 이미지 미리보기">
                            <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#adb5bd"
                                 viewBox="0 0 16 16">
                                <path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
                                <path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2zM14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1zM2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10z"/>
                            </svg>
                        </div>
                        <div id="themeImageUploadZone" class="drop-zone">
                            <div class="drop-zone-prompt">
                                <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#adb5bd"
                                     viewBox="0 0 16 16">
                                    <path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
                                    <path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2zM14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1zM2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10z"/>
                                </svg>
                                <span>여기에 드래그하거나 클릭하세요</span>
                            </div>
                            <input type="file" class="drop-zone-input" id="themeImgFile" name="themeImgUrl"
                                   accept="image/png, image/jpeg, image/gif, image/webp">
                        </div>
                    </div>
                </div>
                <div id="imageUploadContainer" class="mb-2 d-none">
                    <h5 class="mb-3 form-label">이미지 아이템 업로드</h5>
                    <div id="imageDropZone" class="drop-zone">
                        <div class="drop-zone-prompt">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="#adb5bd"
                                 viewBox="0 0 16 16">
                                <path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
                                <path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2zM14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1zM2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10z"/>
                            </svg>
                            <span>여기에 드래그하거나 클릭하세요</span>
                        </div>
                        <input type="file" class="drop-zone-input" id="imageUploadInput" multiple
                               accept="image/png, image/jpeg, image/gif, image/webp">
                    </div>
                </div>
                <div id="videoUploadContainer" class="mb-4">
                    <h5 class="mb-3 form-label">유튜브 아이템 추가</h5>
                    <div class="input-group mb-3 video-input-group" style="gap: 3px">
                        <input type="url" class="form-control input-border-round" id="videoLinkInput"
                               placeholder="YouTube 링크를 입력하세요">
                        <button type="button" class="btn btn-sm btn-outline-danger input-border-round"
                                id="addVideoLink">링크 추가
                        </button>
                    </div>
                </div>
                <div class="card mt-4 p-3 bg-light">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="mb-0 form-label">추가된 게임 아이템 <span id="itemCount"
                                                                     class="badge bg-secondary">0</span>
                        </h5>
                        <button type="button" class="btn btn-sm btn-outline-danger" id="clearAllItems">모두 삭제
                        </button>
                    </div>
                    <ul class="list-group" id="gameItemsContainer">
                        <li class="list-group-item text-center text-muted" id="emptyItemsMessage">추가된 아이템이 없습니다.
                            아이템을
                            추가해주세요.
                        </li>
                    </ul>
                </div>
                <div class="mt-4 d-flex justify-content-end">
                    <button type="submit" class="btn btn-style" id="submitButton">카테고리 생성</button>
                </div>
            </form>

            <!-- 안내 모달 -->
            <div class="modal fade" id="commonModal" tabindex="-1" aria-labelledby="commonModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="commonModalLabel">알림</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" id="commonModalBody">
                            안내 메시지가 여기에 표시됩니다.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                    id="commonModalCloseBtn">닫기
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="<%= request.getContextPath() %>/static/js/category-create.js"></script>
</body>
</html>
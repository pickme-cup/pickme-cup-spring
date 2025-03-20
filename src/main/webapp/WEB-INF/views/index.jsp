<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PickMe Cup</title>


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

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/dompurify/2.3.8/purify.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

</head>
<body>
<!-- 네비게이션 바 -->
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
                <li class="nav-item">
                    <a class="nav-link" href="#home">홈</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#category">카테고리</a>
                </li>
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="#">인기 순위</a>--%>
                <%--                </li>--%>
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="#">커뮤니티</a>--%>
                <%--                </li>--%>
                <li class="nav-item">
                    <a class="nav-link" href="/create-category">게임 만들기</a>
                </li>
            </ul>
            <%--            <div class="d-flex ms-3">--%>
            <%--                <button class="btn btn-outline-danger" type="button">로그인</button>--%>
            <%--            </div>--%>
        </div>
    </div>
</nav>

<div id="home">
    <!-- 히어로 섹션 (캐러셀 + 오버레이 콘텐츠) -->
    <section class="hero-section">
        <!-- 캐러셀 섹션 -->
        <div id="mainCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="<%= request.getContextPath() %>/static/images/carousel01.webp"
                         class="d-block"
                         alt="이상형 월드컵 이미지 1">
                </div>
                <div class="carousel-item">
                    <img src="<%= request.getContextPath() %>/static/images/carousel02.webp"
                         class="d-block"
                         alt="이상형 월드컵 이미지 2">
                </div>
                <div class="carousel-item">
                    <img src="<%= request.getContextPath() %>/static/images/carousel03.webp"
                         class="d-block"
                         alt="이상형 월드컵 이미지 3">
                </div>
                <div class="carousel-item">
                    <img src="<%= request.getContextPath() %>/static/images/carousel04.webp"
                         class="d-block"
                         alt="이상형 월드컵 이미지 4">
                </div>
                <div class="carousel-item">
                    <img src="<%= request.getContextPath() %>/static/images/carousel05.webp"
                         class="d-block"
                         alt="이상형 월드컵 이미지 5">
                </div>
                <div class="carousel-item">
                    <img src="<%= request.getContextPath() %>/static/images/carousel06.webp"
                         class="d-block"
                         alt="이상형 월드컵 이미지 6">
                </div>
            </div>
        </div>

        <!-- 오버레이 콘텐츠 -->
        <div class="content-overlay">
            <div class="title-section">
                <h1>이상형 월드컵</h1>
                <p class="subtitle">당신의 최애를 찾아보세요!</p>
            </div>
            <!-- 게임 시작 버튼 -->
            <button class="btn btn-style" id="startGameBtn">게임 시작하기</button>

            <!-- AI 플로팅 버튼 -->
            <button id="aiFloatingBtn">
                <img src="<%= request.getContextPath() %>/static/favicon/favicon.svg" alt="AI Chat">
            </button>

            <!-- AI 채팅 모달 -->
            <div id="aiChatModal" class="ai-modal">
                <div class="ai-modal-content">
                    <div class="ai-modal-header">
                        <h5>AI 챗봇</h5>
                        <button id="aiCloseBtn">&times;</button>
                    </div>
                    <div class="ai-modal-body">
                        <div id="aiChatMessages"></div>
                        <input type="text" id="aiChatInput" placeholder="메시지를 입력하세요...">
                        <button id="aiSendBtn">전송</button>
                    </div>
                </div>
            </div>
        </div>

    </section>
</div>

<div id="category" class=" container">
    <!-- 카테고리 섹션 -->
    <div class="category-section">
        <h3 class="mb-4">모든 카테고리</h3>
        <div class="row category-container">
            <%-- 여기에 카테고리 카드들이 추가됨 --%>

        </div>
    </div>

    <div class="footer">
        <p>© 2025 이상형 월드컵. All rights reserved.</p>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const aiFloatingBtn = document.getElementById('aiFloatingBtn');
        const aiChatModal = document.getElementById('aiChatModal');
        const aiCloseBtn = document.getElementById('aiCloseBtn');
        const aiChatMessages = document.getElementById('aiChatMessages');
        const aiChatInput = document.getElementById('aiChatInput');
        const aiSendBtn = document.getElementById('aiSendBtn');

        // 플로팅 버튼 클릭 시 모달 열기
        aiFloatingBtn.addEventListener('click', function () {
            aiChatModal.style.display = 'block';
        });

        // 닫기 버튼 클릭 시 모달 닫기
        aiCloseBtn.addEventListener('click', function () {
            aiChatModal.style.display = 'none';
        });

        // 모달 외부 클릭 시 닫기
        window.addEventListener('click', function (event) {
            if (event.target === aiChatModal) {
                aiChatModal.style.display = 'none';
            }
        });

        // 메시지 전송 기능
        aiSendBtn.addEventListener('click', async function () {
            await sendMessage();
        });

        aiChatInput.addEventListener('keypress', async function (event) {
            if (event.key === 'Enter') {
                await sendMessage();
            }
        });

        async function requestChatPromptResponse(userMessage) {
            const response = await fetch(`/api/llm/gemini?chat=\${userMessage}`, {
                method: `GET`,
                headers: {'Content-type': 'application/json'},
            });

            return response.json();
        }

        async function sendMessage() {
            const userMessage = aiChatInput.value.trim();
            if (userMessage === '') return;

            const userMsgElement = document.createElement('div');
            userMsgElement.classList.add('chat-message', 'user');
            userMsgElement.textContent = userMessage;
            aiChatMessages.appendChild(userMsgElement);
            aiChatMessages.scrollTop = aiChatMessages.scrollHeight;

            aiChatInput.value = '';

            const aiResponse = await requestChatPromptResponse(userMessage);
            console.log(aiResponse);

            const aiMsgElement = document.createElement('div');
            aiMsgElement.classList.add('chat-message', 'ai');
            // aiMsgElement.textContent = aiResponse.prompt_results[aiResponse.prompt_results.length - 1].result;
            marked.setOptions({
                breaks: true,       // 줄바꿈 인식
                gfm: true,          // GitHub Flavored Markdown 활성화
                headerIds: false,   // 헤더 ID 자동 생성 비활성화
                smartLists: true,   // 스마트 목록 활성화
                smartypants: true   // 인용부호, 대시 등 변환 활성화
            });
            aiMsgElement.innerHTML = DOMPurify.sanitize(marked.parse(aiResponse.prompt_results[aiResponse.prompt_results.length - 1].result));
            aiChatMessages.appendChild(aiMsgElement);
            aiChatMessages.scrollTop = aiChatMessages.scrollHeight;

            // AI 응답 (더미 데이터)
            // setTimeout(() => {
            //     const aiMsgElement = document.createElement('div');
            //     aiMsgElement.classList.add('chat-message', 'ai');
            //     aiMsgElement.textContent = "AI 응답: " + userMessage;
            //     aiChatMessages.appendChild(aiMsgElement);
            //     aiChatMessages.scrollTop = aiChatMessages.scrollHeight;
            // }, 1000);
        }

        function createCategoryCard(categoryTitle, itemType, imgUrl) {
            // 새로운 카테고리 카드 HTML 요소 생성
            const categoryCard = document.createElement('div');
            categoryCard.classList.add('col-md-4');

            // 카드 요소 생성
            const card = document.createElement('div');
            card.classList.add('category-card', 'card');

            // 이미지 요소 생성 및 속성 설정
            const img = document.createElement('img');
            img.classList.add('card-img-top');
            img.setAttribute('src', imgUrl); // src 속성 안전하게 설정
            img.setAttribute('alt', '이미지'); // alt 속성 설정

            // 카드 본문 내용 생성
            const cardBody = document.createElement('div');
            cardBody.classList.add('card-body');

            // 제목 텍스트 생성
            const cardTitle = document.createElement('h5');
            cardTitle.classList.add('card-title');
            cardTitle.textContent = categoryTitle; // textContent를 사용하여 텍스트 삽입

            // 카드 본문에 제목 추가
            cardBody.appendChild(cardTitle);

            // 카드에 hidden으로 아이템 타입 추가
            const inputItemType = document.createElement(`input`);
            inputItemType.type = `hidden`;
            inputItemType.name = `itemType`;
            inputItemType.value = itemType;

            // 카드에 이미지와 본문 추가
            card.appendChild(img);
            card.appendChild(cardBody);
            card.appendChild(inputItemType);

            // 최상위 요소에 카드 이미지와 본문 추가
            categoryCard.appendChild(card);

            // 카테고리 카드 부모 요소에 추가
            const categoryContainer = document.querySelector('.category-container');
            categoryContainer.appendChild(categoryCard);
        }

        // 캐러셀 관련 기능을 별도 함수로 분리
        function setupCarousel() {
            const mainCarousel = document.getElementById('mainCarousel');
            const directions = ['top', 'bottom', 'left', 'right', 'top left', 'top right', 'bottom left', 'bottom right'];

            // 캐러셀 자동 재생 설정
            const carousel = new bootstrap.Carousel(mainCarousel, {
                interval: 5000,
                wrap: true
            });

            carousel.cycle();

            // 방향에 따른 transformOrigin 값 매핑 객체
            const transformOriginMap = {
                'top': 'center top',
                'bottom': 'center bottom',
                'left': 'left center',
                'right': 'right center',
                'top left': 'top left',
                'top right': 'top right',
                'bottom left': 'bottom left',
                'bottom right': 'bottom right'
            };

            // 랜덤 방향 애니메이션 적용 함수
            function applyRandomDirectionAnimation(carouselItem) {
                const activeImg = carouselItem.querySelector('img');
                const randomDirectionIndex = Math.floor(Math.random() * directions.length);
                const selectedDirection = directions[randomDirectionIndex];

                activeImg.style.transformOrigin = transformOriginMap[selectedDirection] || 'center center';
                activeImg.style.offsetWidth; // 리플로우 트리거
            }

            // 이미지 애니메이션 설정 함수
            function setupImageAnimation(carouselItem) {
                const img = carouselItem.querySelector("img");
                img.style.transform = "scale(1.05)";
                img.style.transition = "transform 10s ease-out";
                applyRandomDirectionAnimation(carouselItem);
            }

            // 초기 활성 캐러셀 아이템 애니메이션 설정
            const initialActiveCarouselItem = mainCarousel.querySelector('.carousel-item.active');
            const firstImg = initialActiveCarouselItem.querySelector('img');

            if (firstImg.complete) {
                firstImg.style.transform = "scale(1)";
                firstImg.style.transition = "transform 10s ease-out";
                applyRandomDirectionAnimation(initialActiveCarouselItem);
            } else {
                firstImg.onload = () => {
                    firstImg.style.transform = "scale(1)";
                    firstImg.style.transition = "transform 10s ease-out";
                    applyRandomDirectionAnimation(initialActiveCarouselItem);
                }
            }

            // 캐러셀 이벤트 리스너 등록
            mainCarousel.addEventListener('slide.bs.carousel', function () {
                const activeCarouselItem = mainCarousel.querySelector('.carousel-item.active');
                activeCarouselItem.querySelector("img").style.transform = "scale(1)";
            });

            mainCarousel.addEventListener('slid.bs.carousel', function () {
                const activeCarouselItem = mainCarousel.querySelector('.carousel-item.active');
                setupImageAnimation(activeCarouselItem);
            });
        }

        // 카테고리 애니메이션 설정 함수
        function setupCategoryAnimation() {
            const categorySection = document.querySelector('.category-section');

            const observer = new IntersectionObserver(entries => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        categorySection.classList.add('visible');
                    } else {
                        categorySection.classList.remove('visible');
                    }
                });
            }, {threshold: 0.2});

            observer.observe(categorySection);
        }

        // 게임 시작 버튼 클릭 이벤트
        document.getElementById('startGameBtn').addEventListener('click', function () {
            window.location.href = '#category';
        });

        document.querySelectorAll('a.nav-link').forEach(link => {
            link.addEventListener('click', function (e) {
                const targetId = this.getAttribute('href');
                if (targetId.startsWith("#")) {
                    e.preventDefault();
                    const targetElement = document.querySelector(targetId);
                    const navbarHeight = document.querySelector('.navbar').offsetHeight;

                    window.scrollTo({
                        top: targetElement.offsetTop - navbarHeight,
                        behavior: 'smooth' // 부드러운 스크롤 효과
                    });
                }
            });
        });

        const categoryItems = <%= request.getAttribute("categories") %>;
        categoryItems.forEach((item) => {
            createCategoryCard(item.theme, item.item_type, item.theme_img_url);
        })

        // 카테고리 카드 클릭 이벤트
        const categoryCards = document.querySelectorAll('.category-card');
        categoryCards.forEach(card => {
            card.addEventListener('click', function () {
                const category = encodeURIComponent(this.querySelector('.card-title').textContent);
                const itemType = this.querySelector('input[name="itemType"]').value;
                window.location.href = `/worldcup?theme=\${category}&type=\${itemType}`;
            });
        });

        // 캐러셀 설정 및 이벤트 처리
        setupCarousel();

        // 네비게이션 활성화 상태 표시
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => {
            if (link.getAttribute('href') === window.location.pathname.split('/').pop()) {
                link.parentElement.classList.add('active');
            }
        });

        // 스크롤 시 '인기 카테고리' 섹션 페이드인 효과 적용
        setupCategoryAnimation();
    }, {once: true});

</script>
</body>
</html>
document.addEventListener('DOMContentLoaded', function () {
    const urlParams = new URLSearchParams(window.location.search);
    const gameType = urlParams.get("type") || "YOUTUBE"; // 기본값은 YOUTUBE

    let items = [];
    let players = [];
    let playersReadyCount = 0;
    let currentPair = [];
    let currentRound = 0;
    let currentItemCount = 1;
    let itemsLoaded = false;
    let playersReady = false;

    // 진행바 업데이트를 위한 변수
    let roundMatchesCompleted = 0;
    let roundTotalMatches = 0;

    function adjustToLowerPowerOfTwo(array) {
        let length = array.length;
        let lowerPowerOfTwo = Math.pow(2, Math.floor(Math.log2(length)));
        return (length === lowerPowerOfTwo) ? array : array.slice(0, lowerPowerOfTwo);
    }

    function setFirstRound(array) {
        items = adjustToLowerPowerOfTwo(array);
        currentRound = items.length;
        currentItemCount = 1;
        roundMatchesCompleted = 0;
        roundTotalMatches = currentRound / 2;
    }

    function shuffleArray(array) {
        return array.sort(() => Math.random() - 0.5);
    }

    function updateProgressContainer() {
        const progressBar = document.querySelector('.progress-bar');
        const progressText = document.querySelector('.progress-text');
        let progressPercent = (roundMatchesCompleted / roundTotalMatches) * 100;
        progressBar.style.width = progressPercent + '%';
        progressBar.setAttribute('aria-valuenow', progressPercent.toString());
        progressText.textContent = (currentRound > 2)
            ? (roundMatchesCompleted) + '/' + roundTotalMatches + ' 진행 중 (' + currentRound + '강)'
            : "결승 진행 중";
    }

    async function updatePlayCount(theme) {
        console.log("아이템 업데이트 요청 시작");
        try {
            await fetch(`/api/category/${theme}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            console.log("아이템 업데이트 요청 완료");
        } catch (error) {
            console.error("요청 중 오류 발생:", error);
        }
    }

    async function updateTotalWins(id) {
        console.log("아이템 업데이트 요청 시작");
        try {
            await fetch(`/api/items/title/${id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
            });
            console.log("아이템 업데이트 요청 완료");
        } catch (error) {
            console.error("요청 중 오류 발생:", error);
        }
    }

    function winner(item) {
        // YouTube 모드인 경우 모든 플레이어 중지
        if (gameType === "YOUTUBE") {
            players.forEach(player => {
                player.stopVideo();
            });
        }

        // 모달에 우승한 아이템 정보 삽입
        document.querySelector("#resultModal .winner-title").textContent = item.title;

        if (gameType === "YOUTUBE") {
            const videoId = extractVideoId(item.resource_url);
            document.querySelector("#resultModal .winner-youtube-player").src = `https://www.youtube.com/embed/${videoId}`;
        } else {
            document.querySelector("#resultModal .winner-image-container img").src = item.resource_url;
        }

        setTimeout(() => {
            let resultModal = new bootstrap.Modal(document.getElementById("resultModal"));
            resultModal.show();
            updateTotalWins(item.id);
            updatePlayCount(item.category_theme);
        }, 300);
    }

    function displayNextPair() {
        if (items.length < 2) {
            if (currentRound === 1) {
                winner(items[0]);
                return;
            } else {
                items = shuffleArray(items);
                currentRound >>= 1;
                roundMatchesCompleted = 0;
                if (currentRound > 1) {
                    roundTotalMatches = currentRound / 2;
                    updateProgressContainer();
                }
            }
        }

        currentPair = items.splice(0, 2);

        // 각 아이템의 정보를 DOM에 표시
        for (let i = 0; i < 2; i++) {
            const itemCard = document.querySelectorAll('.item-card')[i];

            if (gameType === "YOUTUBE") {
                // 타이틀 설정
                const itemTitle = itemCard.querySelector('.youtube-container .item-title');
                itemTitle.textContent = currentPair[i].title;

                const videoId = extractVideoId(currentPair[i].resource_url);
                if (players[i]) {
                    players[i].cueVideoById(videoId);
                } else {
                    console.error(`플레이어 ${i}가 아직 준비되지 않았습니다.`);
                }
            } else {
                // 타이틀 설정
                const itemTitle = itemCard.querySelector('.image-container .item-title');
                itemTitle.textContent = currentPair[i].title;

                // 이미지 설정
                const imageElement = itemCard.querySelector('.image-container img');
                imageElement.src = currentPair[i].resource_url;
            }
        }
    }

    function selectItem(index) {
        if (gameType === "YOUTUBE") {
            players.forEach((player, i) => {
                if (i !== index) player.stopVideo();
            });
        }

        const cardContainer = document.querySelector(".vs-container");
        cardContainer.style.pointerEvents = "none";
        const cards = document.querySelectorAll(".item-card");
        cards[index].classList.add("selected");
        cards[1 - index].classList.add("unselected");

        if (roundMatchesCompleted < roundTotalMatches) {
            roundMatchesCompleted++;
        }

        updateProgressContainer();

        setTimeout(() => {
            items.push(currentPair[index]);
            if (items.length === currentRound / 2) {
                currentRound >>= 1;
                currentItemCount = 1;
                items = shuffleArray(items);
                if (currentRound > 1) {
                    roundMatchesCompleted = 0;
                    roundTotalMatches = currentRound / 2;
                    updateProgressContainer();
                }
            }
            cards[index].classList.remove("selected");
            cards[1 - index].classList.remove("unselected");
            cardContainer.style.pointerEvents = "auto";
            displayNextPair();
        }, 2000);
    }

    async function readItems(theme) {
        console.log("아이템 요청 시작");
        try {
            const response = await fetch(`/api/items/theme/${theme}`);
            const data = await response.json();
            items = shuffleArray(data);
            itemsLoaded = true;
            console.log("아이템 요청 완료");
            tryStartWorldCup();
        } catch (error) {
            console.error("요청 중 오류 발생:", error);
        }
    }

    function startWorldCup() {
        setFirstRound(items);
        updateProgressContainer();
        displayNextPair();
    }

    function tryStartWorldCup() {
        console.log("월드컵 시작 시도");
        if (itemsLoaded && playersReady) {
            console.log("월드컵 시작 성공");
            document.getElementById("spinner").style.display = "none";
            const gameContainer = document.querySelector(".game-container");
            gameContainer.style.display = "block";
            // 커스텀 페이드 인 업 애니메이션 적용
            gameContainer.classList.add("fade-in-up");
            startWorldCup();
        } else {
            console.log("월드컵 시작 실패");
        }
    }

    function extractVideoId(youtubeLink) {
        try {
            const url = new URL(youtubeLink);
            return url.pathname.startsWith("/embed/")
                ? url.pathname.split("/embed/")[1]
                : url.searchParams.get("v");
        } catch (e) {
            // URL 파싱에 실패한 경우 ID 직접 추출 시도
            const match = youtubeLink.match(/(?:\/embed\/|v=|\/|^)([a-zA-Z0-9_-]{11})/);
            return match ? match[1] : null;
        }
    }

    // YouTube 또는 이미지 표시 요소 설정
    function setupDisplayElements() {
        const youtubeContainers = document.querySelectorAll('.youtube-container');
        const imageContainers = document.querySelectorAll('.image-container');
        const winnerYoutubeContainer = document.querySelector('.winner-youtube-container');
        const winnerImageContainer = document.querySelector('.winner-image-container');

        if (gameType === "IMAGE") {
            // 이미지 모드 설정
            youtubeContainers.forEach(container => {
                container.style.display = 'none';
            });
            imageContainers.forEach(container => {
                container.style.display = 'block';
            });
            winnerYoutubeContainer.style.display = 'none';
            winnerImageContainer.style.display = 'block';

            // YouTube API가 필요 없으므로 이미지 로딩 1초 대기 후 준비 완료 상태로 설정
            setTimeout(() => {
                playersReady = true;
                const theme = urlParams.get("theme");
                readItems(theme);
            }, 1000);

            // const theme = urlParams.get("theme");
            // readItems(theme);
        } else {
            // YouTube 모드 설정 (기본값)
            youtubeContainers.forEach(container => {
                container.style.display = 'block';
            });
            imageContainers.forEach(container => {
                container.style.display = 'none';
            });
            winnerYoutubeContainer.style.display = 'block';
            winnerImageContainer.style.display = 'none';

            // YouTube API 초기화 진행
            initializeYouTubePlayers();
        }
    }

    function initializeYouTubePlayers() {
        console.log("유튜브 API 초기화 시작");

        // YouTube API가 이미 로드되었는지 확인
        if (typeof YT !== 'undefined' && YT.Player) {
            onYouTubeIframeAPIReady();
        } else {
            // YouTube API가 로드되면 호출될 콜백 설정
            window.onYouTubeIframeAPIReady = function () {
                onYouTubeIframeAPIReady();
            };
        }
    }

    function onYouTubeIframeAPIReady() {
        console.log("유튜브 API 준비 완료");
        const iframeElements = document.querySelectorAll(".youtube-player");
        iframeElements.forEach((iframe, index) => {
            players.push(
                new YT.Player(iframe, {
                    events: {
                        onReady: onPlayerReady,
                        onStateChange: onPlayerStateChange,
                    },
                })
            );
        });
    }

    function onPlayerReady(event) {
        event.target.pauseVideo();
        playersReadyCount += 1;
        console.log("준비 완료된 플레이어 수: ", playersReadyCount);
        if (playersReadyCount === 2) {
            console.log("모든 플레이어 준비 완료");
            playersReady = true;
            const theme = urlParams.get("theme");
            readItems(theme);
        }
    }

    function onPlayerStateChange(event) {
        if (event.data === YT.PlayerState.PLAYING) {
            players.forEach((player) => {
                if (player !== event.target) player.pauseVideo();
            });
        }
    }

    // 이벤트 리스너 설정
    function setupEventListeners() {
        document.querySelector(".game-title").textContent = urlParams.get("theme");

        document.querySelector(".modal-close").addEventListener("click", function () {
            if (gameType === "YOUTUBE") {
                document.querySelector("#resultModal iframe").src = "";
            }
        });

        // 닫기 버튼 클릭 시 / 링크로 이동
        document.getElementById("resultBtn").addEventListener("click", function () {
            window.location.href = "/";
        });

        // 다시 플레이 버튼 클릭 시 현재 페이지 새로고침
        document.getElementById("restartBtn").addEventListener("click", function () {
            window.location.reload();
        });

        // 아이템 선택 이벤트
        document.querySelectorAll(".item-card").forEach((card, index) => {
            card.addEventListener("click", () => {
                selectItem(index);
            });
        });
    }

    // 초기화 함수
    function init() {
        setupEventListeners();
        setupDisplayElements();
    }

    // 시작
    init();
});
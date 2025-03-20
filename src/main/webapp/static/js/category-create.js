document.addEventListener('DOMContentLoaded', function () {
    // 요소 참조
    const itemTypeSelect = document.getElementById('itemType');
    const imageUploadContainer = document.getElementById('imageUploadContainer');
    const videoUploadContainer = document.getElementById('videoUploadContainer');
    const gameItemsContainer = document.getElementById('gameItemsContainer');
    const clearAllItemsBtn = document.getElementById('clearAllItems');
    const addVideoLinkBtn = document.getElementById('addVideoLink');
    const videoLinkInput = document.getElementById('videoLinkInput');
    const themeImageUploadZone = document.getElementById('themeImageUploadZone');
    const themeImgFileInput = document.getElementById('themeImgFile');
    const themeImagePreview = document.getElementById('themeImagePreview');
    const themeImagePreviewImg = themeImagePreview.querySelector('img'); // 테마 이미지 미리보기 img 태그
    const imageDropZone = document.getElementById('imageDropZone');
    const imageUploadInput = document.getElementById('imageUploadInput');
    const submitButton = document.getElementById('submitButton');
    const themeInput = document.getElementById('theme'); // 카테고리 테마 입력 필드
    const {createFFmpeg, fetchFile} = FFmpeg || {};

    // 전역 변수로 테마 이미지 파일 저장
    let themeImageFile = null;

    // 기본 UI 업데이트
    function updateItemCount() {
        document.getElementById('itemCount').innerText = gameItemsContainer.querySelectorAll('li.list-group-item[data-type]').length;
    }

    function updateItemTypeUI() {
        const type = itemTypeSelect.value;
        if (type === 'IMAGE') {
            imageUploadContainer.classList.remove('d-none');
            videoUploadContainer.classList.add('d-none');
        } else {
            videoUploadContainer.classList.remove('d-none');
            imageUploadContainer.classList.add('d-none');
        }
        gameItemsContainer.innerHTML = '<li class="list-group-item text-center text-muted" id="emptyItemsMessage">추가된 아이템이 없습니다. 아이템을 추가해주세요.</li>';
        themeImagePreviewImg.style.display = "none";
        updateItemCount();
    }

    // createElement 헬퍼 (없다면 아래와 같이 구현)
    function createElement(tag, options = {}) {
        const elem = document.createElement(tag);
        if (options.className) elem.className = options.className;
        if (options.innerText) elem.innerText = options.innerText;
        if (options.type) elem.type = options.type;
        if (options.src) elem.src = options.src;
        if (options.alt) elem.alt = options.alt;
        if (options.value) elem.value = options.value;
        if (options.attributes) {
            for (const key in options.attributes) {
                elem.setAttribute(key, options.attributes[key]);
            }
        }
        if (options.style) {
            for (const key in options.style) {
                elem.style[key] = options.style[key];
            }
        }
        return elem;
    }

    // 이미지 아이템 추가 함수 (파일 객체를 요소에 저장)
    function addImageItem(file) {
        const emptyMessage = document.getElementById('emptyItemsMessage');
        if (emptyMessage) emptyMessage.remove();

        const listItem = createElement('li', {
            className: 'list-group-item d-flex align-items-center',
            attributes: {'data-type': 'IMAGE'},
            style: {gap: '15px'}
        });
        // 파일 객체 저장 (업로드 시 사용)
        listItem.file = file;

        const imgPreview = createElement('img', {
            className: 'img-thumbnail me-2',
            src: URL.createObjectURL(file),
            alt: file.name
        });

        const textContainer = createElement('div', {className: 'item-info flex-grow-1 d-flex align-items-center justify-content-between'});
        const infoGroup = createElement('div', {style: {display: 'flex', gap: '15px', flexGrow: '1'}});

        const titleDiv = createElement('div', {
            style: {
                width: '100%',
                maxWidth: '400px',
                display: 'flex',
                alignItems: 'center'
            }
        });
        const titleLabel = createElement('label', {innerText: '제목:', style: {marginRight: '5px', width: '40px'}});
        const titleInput = createElement('input', {
            type: 'text',
            className: 'form-control form-control-sm',
            value: file.name
        });
        titleDiv.appendChild(titleLabel);
        titleDiv.appendChild(titleInput);
        infoGroup.appendChild(titleDiv);

        const fileDiv = createElement('div', {style: {display: 'flex', alignItems: 'center'}});
        const fileLabel = createElement('label', {innerText: '파일명:', style: {marginRight: '5px', width: '70px'}});
        const fileNameSpan = createElement('span', {innerText: file.name});
        fileDiv.appendChild(fileLabel);
        fileDiv.appendChild(fileNameSpan);
        infoGroup.appendChild(fileDiv);

        textContainer.appendChild(infoGroup);

        const deleteBtn = createElement('button', {
            type: 'button',
            className: 'btn btn-danger btn-sm ms-2',
            innerText: '삭제'
        });
        deleteBtn.addEventListener('click', function () {
            listItem.remove();
            updateItemCount();
        });

        listItem.appendChild(imgPreview);
        listItem.appendChild(textContainer);
        listItem.appendChild(deleteBtn);
        gameItemsContainer.appendChild(listItem);
        updateItemCount();
    }

    // 비디오 아이템 추가 함수
    function addVideoItem(link) {
        if (!link) return;
        const emptyMessage = document.getElementById('emptyItemsMessage');
        if (emptyMessage) emptyMessage.remove();

        const listItem = createElement('li', {
            className: 'list-group-item d-flex align-items-center',
            attributes: {'data-type': 'YOUTUBE'}
        });

        const textContainer = createElement('div', {className: 'item-info flex-grow-1 d-flex align-items-center justify-content-between'});
        const infoGroup = createElement('div', {style: {display: 'flex', gap: '15px', flexGrow: '1'}});

        const titleDiv = createElement('div', {style: {display: 'flex', alignItems: 'center'}});
        const titleLabel = createElement('label', {innerText: '제목:', style: {marginRight: '5px', width: '40px'}});
        const titleInput = createElement('input', {
            type: 'text',
            className: 'form-control form-control-sm',
            value: link,
            style: {width: '400px'}
        });
        titleDiv.appendChild(titleLabel);
        titleDiv.appendChild(titleInput);
        infoGroup.appendChild(titleDiv);

        const linkDiv = createElement('div', {style: {display: 'flex', alignItems: 'center', width: '100%'}});
        const linkLabel = createElement('label', {
            innerText: '유튜브 링크:',
            style: {marginRight: '5px', width: '100px'}
        });
        const linkInput = createElement('input', {
            type: 'url',
            className: 'form-control form-control-sm',
            value: link,
            style: {width: '100%'}
        });
        linkDiv.appendChild(linkLabel);
        linkDiv.appendChild(linkInput);
        infoGroup.appendChild(linkDiv);

        textContainer.appendChild(infoGroup);

        const deleteBtn = createElement('button', {
            type: 'button',
            className: 'btn btn-danger btn-sm ms-2',
            innerText: '삭제'
        });
        deleteBtn.addEventListener('click', function () {
            listItem.remove();
            updateItemCount();
        });

        listItem.appendChild(textContainer);
        listItem.appendChild(deleteBtn);
        gameItemsContainer.appendChild(listItem);
        updateItemCount();
    }

    // 범용 드래그앤드랍 함수
    function setupDropZone(dropZone, fileInput, callback, allowMultiple) {
        dropZone.addEventListener('click', function () {
            fileInput.click();
        });
        fileInput.addEventListener('change', function (e) {
            const files = e.target.files;
            if (files.length) {
                for (let i = 0; i < files.length; i++) {
                    callback(files[i]);
                }
                fileInput.value = '';
            }
        });
        dropZone.addEventListener('dragover', function (e) {
            e.preventDefault();
            dropZone.classList.add('drop-zone-over');
        });
        dropZone.addEventListener('dragleave', function (e) {
            dropZone.classList.remove('drop-zone-over');
        });
        dropZone.addEventListener('drop', function (e) {
            e.preventDefault();
            dropZone.classList.remove('drop-zone-over');
            const files = e.dataTransfer.files;
            if (files.length) {
                if (!allowMultiple && files.length > 1) {
                    callback(files[0]);
                } else {
                    for (let i = 0; i < files.length; i++) {
                        callback(files[i]);
                    }
                }
            }
        });
    }

    // 테마 이미지 드롭존 설정 (파일 객체 저장)
    setupDropZone(themeImageUploadZone, themeImgFileInput, function (file) {
        const previewSVG = themeImagePreview.querySelector("svg");
        previewSVG.style.display = `none`;
        themeImagePreviewImg.style.display = "block";
        themeImagePreviewImg.src = URL.createObjectURL(file);
        themeImagePreviewImg.alt = file.name;

        // 테마 이미지 파일 저장
        themeImageFile = file;
        updateItemCount();
    }, false);

    // 아이템 이미지 드롭존 (이미지 타입)
    setupDropZone(imageDropZone, imageUploadInput, function (file) {
        if (itemTypeSelect.value === 'IMAGE') {
            addImageItem(file);
        }
    }, true);

    // 비디오 링크 추가 버튼 이벤트 (팝오버로 유효하지 않은 링크 알림)
    let videoLinkPopover = null;
    addVideoLinkBtn.addEventListener('click', function () {
        const link = videoLinkInput.value.trim();
        const youtubeRegex = /^(https?:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)[\w-]+/;
        if (!youtubeRegex.test(link)) {
            if (videoLinkPopover) {
                videoLinkPopover.dispose();
            }
            videoLinkPopover = new bootstrap.Popover(addVideoLinkBtn, {
                trigger: 'manual',
                placement: 'right',
                content: '유효한 유튜브 링크를 입력해주세요.'
            });
            videoLinkPopover.show();
            setTimeout(() => {
                videoLinkPopover.hide();
            }, 3000);
            return;
        }
        if (link && itemTypeSelect.value === 'YOUTUBE') {
            addVideoItem(link);
            videoLinkInput.value = '';
        }
    });

    function showLoadingOverlay() {
        document.getElementById('loadingOverlay').style.display = 'flex';
    }

    function hideLoadingOverlay() {
        document.getElementById('loadingOverlay').style.display = 'none';
    }

    // "모두 삭제" 버튼 이벤트
    clearAllItemsBtn.addEventListener('click', function () {
        gameItemsContainer.innerHTML = '<li class="list-group-item text-center text-muted" id="emptyItemsMessage">추가된 아이템이 없습니다. 아이템을 추가해주세요.</li>';
        updateItemCount();
    });

    // 아이템 타입 변경 시 UI 업데이트
    itemTypeSelect.addEventListener('change', function () {
        themeImageFile = null;
        const previewSVG = themeImagePreview.querySelector("svg");
        previewSVG.style.display = `block`;
        updateItemTypeUI();
    });

    const ffmpeg = createFFmpeg ? createFFmpeg({log: true}) : null;
    let ffmpegLoaded = false;

    // 안전한 파일명으로 변환하는 함수 (영문, 숫자, 밑줄, 점만 허용)
    function sanitizeFileName(fileName) {
        return fileName.replace(/[^\w.-]/g, '_');
    }

    // FFmpeg 로딩 (애니메이션 GIF 변환 시 필요)
    async function loadFFmpeg() {
        if (ffmpeg && !ffmpegLoaded) {
            await ffmpeg.load();
            ffmpegLoaded = true;
        }
    }

    async function convertAnimatedGifToWebp(arrayBuffer, fileName) {
        // 파일명을 안전한 ASCII 형식으로 변환
        const safeFileName = sanitizeFileName(fileName);

        // FFmpeg 라이브러리가 로드되어야 합니다.
        await loadFFmpeg();
        if (!ffmpeg) {
            throw new Error('FFmpeg 라이브러리가 로드되지 않았습니다.');
        }

        // FFmpeg 가상 파일 시스템에 입력 파일 저장 (안전한 파일명 사용)
        ffmpeg.FS('writeFile', safeFileName, new Uint8Array(arrayBuffer));

        // 출력 파일명 (원본 확장자를 .webp로 변경)
        const outputFileName = safeFileName.replace(/\.\w+$/, ".webp");

        // 움짤(GIF)을 WebP 애니메이션으로 변환 (무한 반복 포함)
        await ffmpeg.run(
            '-i', safeFileName,
            '-c:v', 'libwebp',
            '-preset', 'picture', // 'picture'는 빠른 인코딩에 최적화됨
            '-q:v', '50',         // 품질 낮추기 (0-100 사이, 낮을수록 빠름)
            '-compression_level', '1', // 압축 레벨 낮추기 (0-6 사이, 낮을수록 빠름)
            '-method', '0',       // 인코딩 방법 (0-6 사이, 낮을수록 빠름)
            '-an',                // 오디오 제거
            '-vsync', '0',        // 기본 프레임 동기화
            '-loop', '0',         // 무한 반복
            '-threads', '4',         // 스레드 수 증가 (브라우저 환경에 맞게 조정)
            '-filter:v', 'fps=10',   // 프레임 레이트 낮추기 (원본이 더 높은 경우)
            outputFileName
        );

        await new Promise(resolve => setTimeout(resolve, 100));

        // 변환된 파일 읽기
        const data = ffmpeg.FS('readFile', outputFileName);

        // 임시 파일 삭제
        ffmpeg.FS('unlink', safeFileName);
        ffmpeg.FS('unlink', outputFileName);

        return new Blob([data.buffer], {type: 'image/webp'});
    }

    async function convertToWebP(file) {
        // 파일이 GIF(움짤)인 경우 FFmpeg를 이용한 변환
        if (file.type === "image/gif") {
            try {
                const arrayBuffer = await file.arrayBuffer();
                return await convertAnimatedGifToWebp(arrayBuffer, file.name);
            } catch (err) {
                console.error("Animated GIF to WebP conversion failed:", err);
                throw err;
            }
        } else {
            // 정적 이미지는 canvas를 이용한 변환
            return new Promise((resolve, reject) => {
                const img = new Image();
                img.onload = function () {
                    const canvas = document.createElement('canvas');
                    canvas.width = img.width;
                    canvas.height = img.height;
                    const ctx = canvas.getContext('2d');
                    ctx.drawImage(img, 0, 0);
                    canvas.toBlob(blob => {
                        if (blob) {
                            resolve(blob);
                        } else {
                            reject(new Error("Canvas toBlob conversion failed"));
                        }
                    }, 'image/webp');
                };
                img.onerror = function (error) {
                    reject(error);
                };
                img.src = URL.createObjectURL(file);
            });
        }
    }

    // 이미지 업로드 함수 (WebP 변환된 파일과 원본 이름을 받아 업로드 후 URL 반환)
    const uploadImage = async (webpFile, originalName) => {
        const formData = new FormData();
        formData.append('file', webpFile, `${originalName.replace(/\.\w+$/, ".webp")}`);
        const res = await fetch('/s3/images', {method: 'POST', body: formData});
        if (!res.ok) throw new Error('이미지 업로드 실패');
        const data = await res.json();
        return data.imgUrl;
    };

    // 지정된 요소에 팝오버를 새롭게 보여줌
    const showPopover = (element, message) => {
        const existingPopover = bootstrap.Popover.getInstance(element);
        if (existingPopover) {
            existingPopover.dispose();
        }
        const popover = new bootstrap.Popover(element, {
            trigger: 'manual',
            placement: 'right',
            content: message
        });
        popover.show();
        setTimeout(() => popover.hide(), 3000);
    };

    // 안내 메시지 모달을 띄우는 함수
    function showModal(title, message, reload = false) {
        document.getElementById("commonModalLabel").innerText = title;
        document.getElementById("commonModalBody").innerText = message;

        // 페이지 새로고침 여부 설정
        const closeButton = document.getElementById("commonModalCloseBtn");
        if (reload) {
            closeButton.onclick = () => window.location.href = "/";
        } else {
            closeButton.onclick = null;
        }

        new bootstrap.Modal(document.getElementById("commonModal")).show();
    }

    submitButton.addEventListener('click', async (e) => {
        e.preventDefault();
        showLoadingOverlay();

        // 입력값 검증
        if (!themeInput.value) {
            showPopover(themeInput, '카테고리 테마를 입력해주세요.');
            hideLoadingOverlay();
            return;
        }
        if (!themeImageFile) {
            showPopover(themeImageUploadZone, '테마 이미지를 추가해주세요.');
            hideLoadingOverlay();
            return;
        }
        const itemCount = gameItemsContainer.querySelectorAll('li.list-group-item[data-type]').length;
        if (itemCount < 4) {
            showPopover(submitButton, '아이템을 최소 4개 이상 추가해주세요.');
            hideLoadingOverlay();
            return;
        }

        try {
            // 0. 카테고리 중복 확인
            const duplicateResponse = await fetch(`/api/category?theme=${themeInput.value}`, {method: 'GET'});
            if (duplicateResponse.status === 200) {
                showModal("카테고리 중복", "이미 존재하는 카테고리입니다. 다른 이름을 입력하세요.");
                hideLoadingOverlay();
                return;
            }

            // 1. 테마 이미지 변환 (단일 파일이므로 그대로 처리)
            const themeWebP = await convertToWebP(themeImageFile);
            // 변환 실패 체크
            if (!themeWebP) {
                throw new Error("테마 이미지 변환 실패");
            }

            // 2. 아이템 이미지(WebP 변환) 처리
            let itemWebPArray = [];
            let gameItemsData = [];
            if (itemTypeSelect.value === 'IMAGE') {
                const imageItems = Array.from(gameItemsContainer.querySelectorAll('li.list-group-item[data-type="IMAGE"]'));
                // 결과 배열을 이미지 아이템 순서에 맞게 초기화
                itemWebPArray = new Array(imageItems.length);
                // 병렬 변환 가능한(non-GIF) 파일들을 위한 배열
                let nonGifPromises = [];
                let nonGifIndices = [];

                for (let i = 0; i < imageItems.length; i++) {
                    const file = imageItems[i].file;
                    if (!file) {
                        itemWebPArray[i] = null;
                    } else if (file.type === 'image/gif') {
                        // GIF는 순차적으로 변환하여 ffmpeg.wasm 명령 충돌 방지
                        itemWebPArray[i] = await convertToWebP(file);
                    } else {
                        // GIF가 아닌 파일은 병렬 처리
                        nonGifIndices.push(i);
                        nonGifPromises.push(convertToWebP(file));
                    }
                }
                // 병렬 변환 결과를 순서에 맞게 할당
                const nonGifResults = await Promise.all(nonGifPromises);
                nonGifIndices.forEach((idx, j) => {
                    itemWebPArray[idx] = nonGifResults[j];
                });

                // 변환 실패 여부 체크
                if (itemWebPArray.includes(null)) {
                    throw new Error("일부 아이템 이미지 변환 실패");
                }

                // 변환된 결과를 이용해 아이템 데이터 구성
                for (let i = 0; i < imageItems.length; i++) {
                    const listItem = imageItems[i];
                    const title = listItem.querySelector('input[type="text"]')?.value || '';
                    let resourceUrl = null;
                    if (listItem.file && itemWebPArray[i]) {
                        resourceUrl = await uploadImage(itemWebPArray[i], listItem.file.name);
                    }
                    gameItemsData.push({
                        title: title,
                        category_theme: themeInput.value,
                        resource_url: resourceUrl
                    });
                }
            } else {
                // YOUTUBE 타입 등 이미지 업로드가 필요없는 경우
                const items = Array.from(gameItemsContainer.querySelectorAll('.list-group-item'));
                gameItemsData = items.map(item => ({
                    title: item.querySelector('input[type="text"]').value,
                    category_theme: themeInput.value,
                    resource_url: item.querySelector('input[type="url"]')?.value || null
                }));
            }

            // 3. 변환된 테마 이미지 업로드
            const themeImgUrl = themeWebP ? await uploadImage(themeWebP, themeImageFile.name) : null;

            // 4. 카테고리 생성 요청 (테마 이미지 URL 포함)
            const categoryData = {
                theme: themeInput.value,
                item_type: itemTypeSelect.value === 'IMAGE' ? 'IMAGE' : 'YOUTUBE',
                theme_img_url: themeImgUrl
            };
            const categoryRes = await fetch('/api/category', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(categoryData)
            });
            if (!categoryRes.ok) throw new Error('카테고리 생성 실패');

            // 5. 아이템 생성 요청
            const itemsRes = await fetch('/api/items', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(gameItemsData)
            });
            if (!itemsRes.ok) throw new Error('아이템 생성 실패');

            showModal("카테고리 생성 완료", "새로운 카테고리 생성을 성공했습니다.", true);
        } catch (error) {
            console.error("전체 요청 중 오류 발생:", error);
            showModal("오류 발생", error.message || "알 수 없는 오류가 발생했습니다.");
        } finally {
            hideLoadingOverlay();
        }
    });

    // 초기 UI 설정
    updateItemTypeUI();
});
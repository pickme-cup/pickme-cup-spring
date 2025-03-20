package org.juyb99.pickmecupspring.controller.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import lombok.extern.slf4j.Slf4j;
import org.juyb99.pickmecupspring.common.Exception.APIException;
import org.juyb99.pickmecupspring.common.util.json.JsonUtil;
import org.juyb99.pickmecupspring.service.StorageService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

@MultipartConfig(
        maxFileSize = 1024 * 1024 * 15,      // 최대 파일 크기 15MB
        maxRequestSize = 1024 * 1024 * 50    // 전체 요청 최대 크기 50MB
)
@RestController
@RequestMapping("/s3/images")
@Slf4j
public class StorageController {
    private final StorageService storageService;

    public StorageController(StorageService storageService) {
        this.storageService = storageService;
    }

    @PostMapping
    public ResponseEntity<String> uploadImage(@RequestParam("file") MultipartFile multipartFile) throws ServletException, IOException {
        String fileName = multipartFile.getOriginalFilename();
        fileName = generateUUIDFileName(Objects.requireNonNull(fileName));
        byte[] imageBytes = multipartFile.getBytes();

        try {
            String imageUrl = storageService.uploadImage(fileName, imageBytes);
            return new ResponseEntity<>(JsonUtil.toJson(Map.of("imgUrl", imageUrl)), HttpStatus.OK);
        } catch (APIException e) {
            log.error(e.getMessage(), e);
            return new ResponseEntity<>(e.getMessage(), e.getStatusCode());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 기존 확장자를 유지하고 UUID로 파일 이름 변경
    private String generateUUIDFileName(String originalFileName) {
        String uuid = UUID.randomUUID().toString(); // 랜덤 UUID 생성
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        return uuid + extension; // UUID + 기존 확장자
    }
}

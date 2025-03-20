package org.juyb99.pickmecupspring.controller.api;

import jakarta.servlet.http.HttpSession;
import org.juyb99.pickmecupspring.dto.request.GeminiRequestDTO;
import org.juyb99.pickmecupspring.dto.response.GeminiResponseDTO;
import org.juyb99.pickmecupspring.model.gemini.GeminiRequest.Content;
import org.juyb99.pickmecupspring.service.GeminiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;

@RestController
@RequestMapping("/api/llm/gemini")
public class GeminiController {
    private final GeminiService geminiService;

    @Autowired
    public GeminiController(GeminiService geminiService) {
        this.geminiService = geminiService;
    }

    @GetMapping
    public ResponseEntity<GeminiResponseDTO> getPromptsResult(@RequestParam("chat") String chat, HttpSession session) {
        GeminiRequestDTO geminiRequestDTO = (GeminiRequestDTO) session.getAttribute("geminiRequestDTO");

        // 첫 대화 시작이라면 세션에 저장할 새 리스트 생성 후 DB 카테고리를 저장해둠.
        if (geminiRequestDTO == null) {
            geminiRequestDTO = new GeminiRequestDTO(new ArrayList<>());
        }

        // 유저 프롬프트를 요청 DTO에 추가
        geminiRequestDTO.contents().add(Content.fromUser(chat));

        // 프롬프트 요청
        GeminiResponseDTO geminiResponseDTO = geminiService.runRequestPrompt(geminiRequestDTO);

        // 주고 받은 대화를 세션에 저장
        session.setAttribute("geminiRequestDTO", geminiRequestDTO);
        return new ResponseEntity<>(geminiResponseDTO, HttpStatus.OK);
    }
}

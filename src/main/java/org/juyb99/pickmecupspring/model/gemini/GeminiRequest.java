package org.juyb99.pickmecupspring.model.gemini;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

import java.util.List;

@Builder
public record GeminiRequest(List<Content> contents, SystemInstruction systemInstruction,
                            GenerationConfig generationConfig) {

    public record Content(String role, List<Part> parts) {
        public Content(String text) {
            this("user", List.of(new Part(text)));
        }

        public static Content fromUser(String text) {
            return new Content("user", List.of(new Part(text)));
        }

        public static Content fromModel(String text) {
            return new Content("model", List.of(new Part(text)));
        }
    }

    /**
     * Gemini 시스템 안내를 설정하는 클래스
     *
     * @param parts
     */
    public record SystemInstruction(Role role, List<Part> parts) {
        public SystemInstruction() {
            this(Role.USER, List.of(new Part("use korean, no markdown")));
        }

        public static SystemInstruction of(String text) {
            return new SystemInstruction(Role.USER, List.of(new Part(text)));
        }

        @Getter
        @ToString
        public enum Role {
            USER("user"), MODEL("model");

            private final String role;

            Role(String role) {
                this.role = role;
            }
        }
    }

    /**
     * Gemini 출력 옵션을 설정하는 클래스
     *
     * @param temperature
     * @param topK
     * @param topP
     * @param maxOutputTokens
     * @param responseMimeType
     */
    public record GenerationConfig(float temperature, int topK, float topP, int maxOutputTokens,
                                   String responseMimeType) {
        public GenerationConfig() {
            this(1.0f, 40, 0.95f, 8192, "text/plain");
        }
    }

    public record Part(String text) {
    }
}

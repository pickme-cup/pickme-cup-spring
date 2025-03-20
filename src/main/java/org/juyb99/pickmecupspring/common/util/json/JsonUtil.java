package org.juyb99.pickmecupspring.common.util.json;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;

public class JsonUtil {
    private static final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 객체를 JSON 문자열로 변환합니다.
     *
     * @param obj 변환할 객체
     * @return JSON 문자열
     */
    public static String toJson(Object obj) {
        try {
            return objectMapper.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * JSON 문자열을 지정한 타입의 객체로 변환합니다.
     *
     * @param json  JSON 문자열
     * @param clazz 대상 클래스
     * @param <T>   제네릭 타입
     * @return 변환된 객체
     */
    public static <T> T fromJson(String json, Class<T> clazz) {
        try {
            return objectMapper.readValue(json, clazz);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * JSON 문자열을 지정한 타입의 리스트 객체로 변환합니다.
     *
     * @param json  JSON 문자열
     * @param clazz 대상 클래스
     * @param <T>   제네릭 타입
     * @return 변환된 객체
     */
    public static <T> List<T> fromJsonList(String json, Class<T> clazz) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.readValue(json, objectMapper.getTypeFactory().constructCollectionType(List.class, clazz));
        } catch (Exception e) {
            throw new RuntimeException("JSON parsing error", e);
        }
    }

}


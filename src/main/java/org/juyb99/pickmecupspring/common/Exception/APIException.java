package org.juyb99.pickmecupspring.common.Exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class APIException extends RuntimeException {
    private final HttpStatus statusCode;

    public APIException(HttpStatus statusCode, String message) {
        super("API 요청 실패 - " + statusCode + ": " + message);
        this.statusCode = statusCode;
    }
}

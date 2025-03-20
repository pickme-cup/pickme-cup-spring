package org.juyb99.pickmecupspring.common.util.httpclient;

import lombok.Builder;
import org.springframework.http.HttpMethod;

/**
 * API 요청에 사용되는 레코드
 *
 * @param url     API 요청 URL
 * @param method  API 요청 HTTP 메서드
 * @param body    요청에 담을 Body
 * @param headers 요청에 필요한 Header
 */
@Builder
public record APIClientParam(String url, HttpMethod method, Object body, String... headers) {

}

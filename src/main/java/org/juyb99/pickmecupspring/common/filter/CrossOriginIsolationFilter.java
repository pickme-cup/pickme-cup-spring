package org.juyb99.pickmecupspring.common.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class CrossOriginIsolationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (response instanceof HttpServletResponse) {
            HttpServletRequest httpReq = (HttpServletRequest) request;
            HttpServletResponse httpResp = (HttpServletResponse) response;
            
            // ffmpeg 라이브러리 사용 시 COOP 정책 차단 방지를 위해 카테고리 생성 페이지 요청에 헤더 추가
            httpResp.setHeader("Cross-Origin-Opener-Policy", "same-origin");
            httpResp.setHeader("Cross-Origin-Embedder-Policy", "require-corp");

        }

        chain.doFilter(request, response);
    }
}
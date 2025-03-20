package org.juyb99.pickmecupspring.dto.request;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.juyb99.pickmecupspring.model.gemini.GeminiRequest.Content;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public record GeminiRequestDTO(List<Content> contents) {
}

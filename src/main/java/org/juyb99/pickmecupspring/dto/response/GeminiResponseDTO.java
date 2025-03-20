package org.juyb99.pickmecupspring.dto.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public record GeminiResponseDTO(@JsonProperty("prompt_results") List<PromptResult> promptResults) {

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record PromptResult(String prompt, String result) {

    }
}

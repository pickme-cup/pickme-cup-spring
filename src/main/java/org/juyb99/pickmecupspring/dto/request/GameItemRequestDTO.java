package org.juyb99.pickmecupspring.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record GameItemRequestDTO(@JsonProperty("title") String title,
                                 @JsonProperty("category_theme") String categoryTheme,
                                 @JsonProperty("resource_url") String resourceUrl) {
}

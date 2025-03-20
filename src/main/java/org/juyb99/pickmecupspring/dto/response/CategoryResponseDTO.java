package org.juyb99.pickmecupspring.dto.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.juyb99.pickmecupspring.model.ItemType;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public record CategoryResponseDTO(@JsonProperty("id") long id,
                                  @JsonProperty("theme") String theme,
                                  @JsonProperty("item_type") ItemType itemType,
                                  @JsonProperty("play_count") int playCount,
                                  @JsonProperty("theme_img_url") String themeImgUrl) {
}

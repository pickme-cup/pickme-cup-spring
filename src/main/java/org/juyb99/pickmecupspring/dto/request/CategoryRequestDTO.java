package org.juyb99.pickmecupspring.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.juyb99.pickmecupspring.model.ItemType;

public record CategoryRequestDTO(@JsonProperty("theme") String theme,
                                 @JsonProperty("item_type") ItemType itemType,
                                 @JsonProperty("theme_img_url") String themeImgUrl) {
}
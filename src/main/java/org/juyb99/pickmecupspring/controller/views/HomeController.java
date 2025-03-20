package org.juyb99.pickmecupspring.controller.views;

import org.juyb99.pickmecupspring.common.util.json.JsonUtil;
import org.juyb99.pickmecupspring.dto.response.CategoryResponseDTO;
import org.juyb99.pickmecupspring.service.CategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/")
public class HomeController {
    private final CategoryService categoryService;

    public HomeController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping
    public String index(Model model) {
        List<CategoryResponseDTO> categories = categoryService.readAllCategories();
        model.addAttribute("categories", JsonUtil.toJson(categories));
        return "index";
    }
}

package org.juyb99.pickmecupspring.controller.views;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/create-category")
public class CreateCategoryController {
    @GetMapping
    public String showCreateCategoryPage(Model model) {
        return "category-create";
    }
}

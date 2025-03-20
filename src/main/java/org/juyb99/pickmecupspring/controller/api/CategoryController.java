package org.juyb99.pickmecupspring.controller.api;

import lombok.extern.slf4j.Slf4j;
import org.juyb99.pickmecupspring.common.Exception.APIException;
import org.juyb99.pickmecupspring.dto.request.CategoryRequestDTO;
import org.juyb99.pickmecupspring.dto.response.CategoryResponseDTO;
import org.juyb99.pickmecupspring.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/category")
@Slf4j
public class CategoryController {
    private final CategoryService categoryService;

    @Autowired
    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping
    public ResponseEntity<CategoryResponseDTO> getCategoryByTheme(@RequestParam(name = "theme") String theme) {
        CategoryResponseDTO category;

        try {
            category = categoryService.readCategoryByTheme(theme);
        } catch (APIException e) {
            log.error(e.getMessage());
            return ResponseEntity.status(e.getStatusCode()).build();
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return new ResponseEntity<>(category, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<CategoryResponseDTO> createCategory(@RequestBody CategoryRequestDTO categoryRequestDTO) {
        CategoryResponseDTO category;

        try {
            category = categoryService.saveCategory(categoryRequestDTO);
        } catch (APIException e) {
            log.error(e.getMessage());
            return ResponseEntity.status(e.getStatusCode()).build();
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

        return new ResponseEntity<>(category, HttpStatus.CREATED);
    }

    @PutMapping("/{categoryTheme}")
    public ResponseEntity<Void> updatePlayCount(@PathVariable("categoryTheme") String theme) {
        categoryService.updatePlayCountByTheme(theme);
        return ResponseEntity.ok().build();
    }
}

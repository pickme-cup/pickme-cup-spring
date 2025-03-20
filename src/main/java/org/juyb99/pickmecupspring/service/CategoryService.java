package org.juyb99.pickmecupspring.service;

import org.juyb99.pickmecupspring.dto.request.CategoryRequestDTO;
import org.juyb99.pickmecupspring.dto.response.CategoryResponseDTO;
import org.juyb99.pickmecupspring.repository.CategoryRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<CategoryResponseDTO> readAllCategories() {
        return categoryRepository.findAll();
    }

    public CategoryResponseDTO readCategoryByTheme(String theme) {
        return categoryRepository.findByTheme(theme);
    }

    public CategoryResponseDTO saveCategory(CategoryRequestDTO categoryRequestDTO) {
        return categoryRepository.save(categoryRequestDTO);
    }

    public void updatePlayCountByTheme(String theme) {
        categoryRepository.updatePlayCountByTheme(theme);
    }

}

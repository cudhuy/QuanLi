package com.quanlynh.service;

import com.quanlynh.dto.CategoryRequest;
import com.quanlynh.entity.Category;
import com.quanlynh.repository.CategoryRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<Category> list() {
        return categoryRepository.findAll();
    }

    public Category get(Long id) {
        return categoryRepository.findById(id).orElseThrow();
    }

    public Category create(CategoryRequest request) {
        Category category = new Category();
        apply(category, request);
        return categoryRepository.save(category);
    }

    public Category update(Long id, CategoryRequest request) {
        Category category = get(id);
        apply(category, request);
        return categoryRepository.save(category);
    }

    public void delete(Long id) {
        categoryRepository.deleteById(id);
    }

    private void apply(Category category, CategoryRequest request) {
        category.setName(request.getName());
        category.setDescription(request.getDescription());
        if (request.getActive() != null) {
            category.setActive(request.getActive());
        }
    }
}

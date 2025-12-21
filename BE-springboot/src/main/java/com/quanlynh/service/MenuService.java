package com.quanlynh.service;

import com.quanlynh.dto.MenuItemRequest;
import com.quanlynh.entity.Category;
import com.quanlynh.entity.MenuItem;
import com.quanlynh.repository.CategoryRepository;
import com.quanlynh.repository.MenuItemRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuService {
    private final MenuItemRepository menuItemRepository;
    private final CategoryRepository categoryRepository;

    public MenuService(MenuItemRepository menuItemRepository, CategoryRepository categoryRepository) {
        this.menuItemRepository = menuItemRepository;
        this.categoryRepository = categoryRepository;
    }

    public List<MenuItem> list() {
        return menuItemRepository.findAll();
    }

    public List<MenuItem> listPopular() {
        return menuItemRepository.findTop5ByOrderByIdDesc();
    }

    public MenuItem create(MenuItemRequest request) {
        MenuItem item = new MenuItem();
        apply(item, request);
        return menuItemRepository.save(item);
    }

    public MenuItem update(Long id, MenuItemRequest request) {
        MenuItem item = menuItemRepository.findById(id).orElseThrow();
        apply(item, request);
        return menuItemRepository.save(item);
    }

    private void apply(MenuItem item, MenuItemRequest request) {
        Category category = categoryRepository.findById(request.getCategoryId()).orElseThrow();
        item.setCategory(category);
        item.setName(request.getName());
        item.setPrice(request.getPrice());
        item.setImage(request.getImageUrl());
    }
}

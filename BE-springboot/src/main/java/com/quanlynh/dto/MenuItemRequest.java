package com.quanlynh.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class MenuItemRequest {
    @NotNull
    private Long categoryId;

    @NotBlank
    private String name;

    @NotNull
    @Min(0)
    private BigDecimal price;

    private String imageUrl;
}

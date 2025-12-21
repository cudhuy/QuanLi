package com.quanlynh.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class TableRequest {
    @NotBlank
    private String name;

    @Min(1)
    private int seats;

    private String status;
}

package com.quanlynh.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class RatingRequest {
    @NotNull
    private Long orderId;

    @Min(1)
    @Max(5)
    private int rating;

    private String comment;
}

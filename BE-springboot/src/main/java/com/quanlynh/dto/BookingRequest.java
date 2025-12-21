package com.quanlynh.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BookingRequest {
    private Long userId;

    @NotBlank
    private String customerName;

    @NotBlank
    private String phone;

    @NotNull
    private LocalDateTime bookingTime;

    @Min(1)
    private int guests;

    private String note;
}

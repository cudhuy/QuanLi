package com.quanlynh.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
public class BookingRequest {
    @NotBlank
    private String customerName;

    @NotBlank
    private String email;

    @NotBlank
    private String phone;

    @NotNull
    private LocalDate bookingDate;

    @NotNull
    private LocalTime bookingTime;

    @Min(1)
    private int guests;

    private String note;
}

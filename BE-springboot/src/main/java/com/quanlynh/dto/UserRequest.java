package com.quanlynh.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.util.Set;

@Data
public class UserRequest {
    @NotBlank
    private String name;

    @NotBlank
    private String email;
    private String phone;

    private String password;

    @NotBlank
    private String role; // admin or staff
}

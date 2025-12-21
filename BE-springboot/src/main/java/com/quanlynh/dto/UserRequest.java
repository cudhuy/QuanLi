package com.quanlynh.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.util.Set;

@Data
public class UserRequest {
    @NotBlank
    private String username;

    private String fullName;
    private String email;
    private String phone;

    private String password;

    private Set<String> roles;
}

package com.quanlynh.controller;

import com.quanlynh.dto.ApiResponse;
import com.quanlynh.dto.LoginRequest;
import com.quanlynh.dto.LoginResponse;
import com.quanlynh.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
public class AuthController {
    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<LoginResponse>> login(@Valid @RequestBody LoginRequest request) {
        LoginResponse response = authService.login(request);
        return ResponseEntity.ok(new ApiResponse<>(response, "login_success"));
    }

    @PostMapping("/logout")
    public ResponseEntity<ApiResponse<String>> logout() {
        return ResponseEntity.ok(new ApiResponse<>("ok", "logout_success"));
    }

    @GetMapping("/user")
    public ResponseEntity<ApiResponse<LoginResponse>> currentUser(@AuthenticationPrincipal org.springframework.security.core.userdetails.User principal) {
        if (principal == null) {
            return ResponseEntity.status(401).body(new ApiResponse<>(null, "unauthorized"));
        }
        LoginResponse resp = new LoginResponse(null, principal.getUsername(),
                principal.getAuthorities().stream().map(a -> a.getAuthority().replace("ROLE_", "").toLowerCase()).toList());
        return ResponseEntity.ok(new ApiResponse<>(resp, "ok"));
    }
}

package com.quanlynh.service;

import com.quanlynh.dto.LoginRequest;
import com.quanlynh.dto.LoginResponse;
import com.quanlynh.entity.User;
import com.quanlynh.repository.UserRepository;
import com.quanlynh.security.JwtService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthService {
    private final AuthenticationManager authenticationManager;
    private final UserRepository userRepository;
    private final JwtService jwtService;

    public AuthService(AuthenticationManager authenticationManager, UserRepository userRepository, JwtService jwtService) {
        this.authenticationManager = authenticationManager;
        this.userRepository = userRepository;
        this.jwtService = jwtService;
    }

    public LoginResponse login(LoginRequest request) {
        Authentication authentication = authenticationManager.authenticate(
            new UsernamePasswordAuthenticationToken(request.getName(), request.getPassword()));
        if (!authentication.isAuthenticated()) {
            throw new IllegalArgumentException("Invalid credentials");
        }
        User user = userRepository.findByName(request.getName())
            .orElseThrow(() -> new IllegalArgumentException("User not found"));
        String role = user.getRole();
        String token = jwtService.generateToken(user.getName(), List.of(role));
        return new LoginResponse(token, user.getName(), List.of(role));
    }
}

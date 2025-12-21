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
            new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword()));
        if (!authentication.isAuthenticated()) {
            throw new IllegalArgumentException("Invalid credentials");
        }
        User user = userRepository.findByUsername(request.getUsername())
            .orElseThrow(() -> new IllegalArgumentException("User not found"));
        List<String> roles = user.getRoles().stream().map(role -> role.getName()).toList();
        String token = jwtService.generateToken(user.getUsername(), roles);
        return new LoginResponse(token, user.getUsername(), roles);
    }
}

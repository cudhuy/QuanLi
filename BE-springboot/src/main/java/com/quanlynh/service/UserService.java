package com.quanlynh.service;

import com.quanlynh.dto.UserRequest;
import com.quanlynh.entity.User;
import com.quanlynh.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public List<User> listUsers() {
        return userRepository.findAll();
    }

    public User getUser(Long id) {
        return userRepository.findById(id).orElseThrow();
    }

    public User createUser(UserRequest request) {
        User user = new User();
        applyRequest(user, request, true);
        return userRepository.save(user);
    }

    public User updateUser(Long id, UserRequest request) {
        User user = getUser(id);
        applyRequest(user, request, request.getPassword() != null && !request.getPassword().isBlank());
        return userRepository.save(user);
    }

    private void applyRequest(User user, UserRequest request, boolean updatePassword) {
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        user.setPhone(request.getPhone());
        user.setRole(request.getRole().toLowerCase());
        if (updatePassword) {
            user.setPassword(passwordEncoder.encode(request.getPassword()));
        }
    }
}

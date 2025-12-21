package com.quanlynh.service;

import com.quanlynh.dto.UserRequest;
import com.quanlynh.entity.Role;
import com.quanlynh.entity.User;
import com.quanlynh.repository.RoleRepository;
import com.quanlynh.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
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
        user.setUsername(request.getUsername());
        user.setFullName(request.getFullName());
        user.setEmail(request.getEmail());
        user.setPhone(request.getPhone());
        if (updatePassword) {
            user.setPasswordHash(passwordEncoder.encode(request.getPassword()));
        }
        if (request.getRoles() != null && !request.getRoles().isEmpty()) {
            Set<Role> roles = new HashSet<>();
            for (String roleName : request.getRoles()) {
                roleRepository.findByName(roleName.toUpperCase()).ifPresent(roles::add);
            }
            user.setRoles(roles);
        }
    }
}

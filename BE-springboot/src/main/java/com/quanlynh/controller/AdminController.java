package com.quanlynh.controller;

import com.quanlynh.dto.*;
import com.quanlynh.entity.*;
import com.quanlynh.service.*;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {
    private final UserService userService;
    private final TableService tableService;
    private final CategoryService categoryService;
    private final MenuService menuService;
    private final BookingService bookingService;
    private final OrderService orderService;

    public AdminController(UserService userService,
                           TableService tableService,
                           CategoryService categoryService,
                           MenuService menuService,
                           BookingService bookingService,
                           OrderService orderService) {
        this.userService = userService;
        this.tableService = tableService;
        this.categoryService = categoryService;
        this.menuService = menuService;
        this.bookingService = bookingService;
        this.orderService = orderService;
    }

    @GetMapping("/list-user")
    public ResponseEntity<ApiResponse<List<User>>> listUsers() {
        return ResponseEntity.ok(new ApiResponse<>(userService.listUsers(), "ok"));
    }

    @PostMapping("/add-user")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<User>> addUser(@Valid @RequestBody UserRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(userService.createUser(request), "created"));
    }

    @PutMapping("/update-user/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<User>> updateUser(@PathVariable Long id, @Valid @RequestBody UserRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(userService.updateUser(id, request), "updated"));
    }

    @GetMapping("/user/{id}")
    public ResponseEntity<ApiResponse<User>> getUser(@PathVariable Long id) {
        return ResponseEntity.ok(new ApiResponse<>(userService.getUser(id), "ok"));
    }

    @PostMapping("/add-table")
    public ResponseEntity<ApiResponse<DiningTable>> addTable(@Valid @RequestBody TableRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(tableService.create(request), "created"));
    }

    @PutMapping("/update-table/{id}")
    public ResponseEntity<ApiResponse<DiningTable>> updateTable(@PathVariable Long id,
                                                                @Valid @RequestBody TableRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(tableService.update(id, request), "updated"));
    }

    @GetMapping("/table/{id}")
    public ResponseEntity<ApiResponse<DiningTable>> getTable(@PathVariable Long id) {
        return ResponseEntity.ok(new ApiResponse<>(tableService.get(id), "ok"));
    }

    @PostMapping("/add-cate")
    public ResponseEntity<ApiResponse<Category>> addCategory(@Valid @RequestBody CategoryRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(categoryService.create(request), "created"));
    }

    @PutMapping("/update-cate/{id}")
    public ResponseEntity<ApiResponse<Category>> updateCategory(@PathVariable Long id,
                                                                 @Valid @RequestBody CategoryRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(categoryService.update(id, request), "updated"));
    }

    @DeleteMapping("/delete-cate/{id}")
    public ResponseEntity<ApiResponse<String>> deleteCategory(@PathVariable Long id) {
        categoryService.delete(id);
        return ResponseEntity.ok(new ApiResponse<>("deleted", "deleted"));
    }

    @GetMapping("/cate/{id}")
    public ResponseEntity<ApiResponse<Category>> getCategory(@PathVariable Long id) {
        return ResponseEntity.ok(new ApiResponse<>(categoryService.get(id), "ok"));
    }

    @PostMapping("/add-menu")
    public ResponseEntity<ApiResponse<MenuItem>> addMenu(@Valid @RequestBody MenuItemRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(menuService.create(request), "created"));
    }

    @PutMapping("/update-menu/{id}")
    public ResponseEntity<ApiResponse<MenuItem>> updateMenu(@PathVariable Long id,
                                                            @Valid @RequestBody MenuItemRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(menuService.update(id, request), "updated"));
    }

    @GetMapping("/list-booking")
    public ResponseEntity<ApiResponse<List<Booking>>> listBooking() {
        return ResponseEntity.ok(new ApiResponse<>(bookingService.list(), "ok"));
    }

    @PutMapping("/update-booking/{id}")
    public ResponseEntity<ApiResponse<Booking>> updateBooking(@PathVariable Long id,
                                                              @Valid @RequestBody StatusUpdateRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(bookingService.updateStatus(id, request.getStatus()), "updated"));
    }

    @PutMapping("/update-order/{id}")
    public ResponseEntity<ApiResponse<Order>> updateOrder(@PathVariable Long id,
                                                          @Valid @RequestBody StatusUpdateRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(orderService.updateStatus(id, request.getStatus()), "updated"));
    }

    @GetMapping("/dashboard")
    public ResponseEntity<ApiResponse<Map<String, Object>>> dashboard() {
        Map<String, Object> data = new HashMap<>();
        data.put("totalUsers", userService.listUsers().size());
        data.put("totalBookings", bookingService.list().size());
        return ResponseEntity.ok(new ApiResponse<>(data, "ok"));
    }
}

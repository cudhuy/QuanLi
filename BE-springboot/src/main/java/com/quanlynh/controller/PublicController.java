package com.quanlynh.controller;

import com.quanlynh.dto.*;
import com.quanlynh.entity.*;
import com.quanlynh.service.*;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class PublicController {
    private final CategoryService categoryService;
    private final TableService tableService;
    private final MenuService menuService;
    private final OrderService orderService;
    private final BookingService bookingService;
    private final RatingService ratingService;
    private final PaymentService paymentService;

    public PublicController(CategoryService categoryService,
                            TableService tableService,
                            MenuService menuService,
                            OrderService orderService,
                            BookingService bookingService,
                            RatingService ratingService,
                            PaymentService paymentService) {
        this.categoryService = categoryService;
        this.tableService = tableService;
        this.menuService = menuService;
        this.orderService = orderService;
        this.bookingService = bookingService;
        this.ratingService = ratingService;
        this.paymentService = paymentService;
    }

    @GetMapping("/cate")
    public ResponseEntity<ApiResponse<List<Category>>> listCategories() {
        return ResponseEntity.ok(new ApiResponse<>(categoryService.list(), "ok"));
    }

    @GetMapping("/table")
    public ResponseEntity<ApiResponse<List<DiningTable>>> listTables() {
        return ResponseEntity.ok(new ApiResponse<>(tableService.list(), "ok"));
    }

    @GetMapping("/list-menu")
    public ResponseEntity<ApiResponse<List<MenuItem>>> listMenu() {
        return ResponseEntity.ok(new ApiResponse<>(menuService.list(), "ok"));
    }

    @GetMapping("/popular-dishes")
    public ResponseEntity<ApiResponse<List<MenuItem>>> popularDishes() {
        return ResponseEntity.ok(new ApiResponse<>(menuService.listPopular(), "ok"));
    }

    @PostMapping("/order")
    public ResponseEntity<ApiResponse<Order>> createOrder(@Valid @RequestBody OrderRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(orderService.create(request), "created"));
    }

    @GetMapping("/order-item/{id}")
    public ResponseEntity<ApiResponse<List<OrderItem>>> orderItems(@PathVariable Long id) {
        return ResponseEntity.ok(new ApiResponse<>(orderService.listItems(id), "ok"));
    }

    @PostMapping("/booking")
    public ResponseEntity<ApiResponse<Booking>> createBooking(@Valid @RequestBody BookingRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(bookingService.create(request), "created"));
    }

    @PostMapping("/chatbox")
    public ResponseEntity<ApiResponse<Map<String, String>>> chatbox(@RequestBody Map<String, String> payload) {
        String message = payload.getOrDefault("message", "");
        return ResponseEntity.ok(new ApiResponse<>(Map.of("reply", "Bot: " + message), "ok"));
    }

    @GetMapping("/rating/form/{order_id}")
    public ResponseEntity<ApiResponse<Rating>> ratingForm(@PathVariable("order_id") Long orderId) {
        return ResponseEntity.ok(new ApiResponse<>(ratingService.getForm(orderId), "ok"));
    }

    @PostMapping("/rating/submit")
    public ResponseEntity<ApiResponse<Rating>> submitRating(@Valid @RequestBody RatingRequest request) {
        return ResponseEntity.ok(new ApiResponse<>(ratingService.create(request), "created"));
    }

    @PostMapping("/payment")
    public ResponseEntity<ApiResponse<Map<String, Object>>> payment(@RequestBody Map<String, Object> payload) {
        return ResponseEntity.ok(new ApiResponse<>(payload, "received"));
    }

    @PostMapping("/vnpay_payment")
    public ResponseEntity<ApiResponse<Map<String, Object>>> vnpayPayment(@RequestBody Map<String, Object> payload) {
        return ResponseEntity.ok(new ApiResponse<>(paymentService.createVnPayPayment(payload), "created"));
    }

    @GetMapping("/vnpay_callback")
    public ResponseEntity<ApiResponse<Map<String, Object>>> vnpayCallback(@RequestParam Map<String, String> params) {
        return ResponseEntity.ok(new ApiResponse<>(paymentService.handleVnPayCallback(params), "ok"));
    }

    @PostMapping("/internal_payment")
    public ResponseEntity<ApiResponse<Map<String, Object>>> internalPayment(@RequestBody Map<String, Object> payload) {
        return ResponseEntity.ok(new ApiResponse<>(paymentService.createInternalPayment(payload), "created"));
    }
}

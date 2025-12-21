package com.quanlynh.controller;

import com.quanlynh.dto.*;
import com.quanlynh.entity.*;
import com.quanlynh.repository.OrderRepository;
import com.quanlynh.service.*;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
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
    private final OrderRepository orderRepository;

    public PublicController(CategoryService categoryService,
                            TableService tableService,
                            MenuService menuService,
                            OrderService orderService,
                            BookingService bookingService,
                            RatingService ratingService,
                            PaymentService paymentService,
                            OrderRepository orderRepository) {
        this.categoryService = categoryService;
        this.tableService = tableService;
        this.menuService = menuService;
        this.orderService = orderService;
        this.bookingService = bookingService;
        this.ratingService = ratingService;
        this.paymentService = paymentService;
        this.orderRepository = orderRepository;
    }

    @GetMapping("/cate")
    public ResponseEntity<ApiResponse<List<Category>>> listCategories() {
        return ResponseEntity.ok(new ApiResponse<>(categoryService.list(), "ok"));
    }

    @GetMapping("/table")
    public ResponseEntity<ApiResponse<List<DiningTable>>> listTables() {
        return ResponseEntity.ok(new ApiResponse<>(tableService.list(), "ok"));
    }

    @GetMapping("/table/{id}")
    public ResponseEntity<ApiResponse<DiningTable>> getTable(@PathVariable Long id) {
        return ResponseEntity.ok(new ApiResponse<>(tableService.get(id), "ok"));
    }

    @GetMapping("/list-menu")
    public ResponseEntity<ApiResponse<List<MenuItem>>> listMenu() {
        return ResponseEntity.ok(new ApiResponse<>(menuService.list(), "ok"));
    }

    @GetMapping("/order")
    public ResponseEntity<ApiResponse<List<Order>>> listOrders() {
        return ResponseEntity.ok(new ApiResponse<>(orderRepository.findAll(), "ok"));
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
    public ResponseEntity<Order> orderDetail(@PathVariable Long id) {
        return ResponseEntity.ok(orderService.getById(id));
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

    @PostMapping("/upload")
    public ResponseEntity<ApiResponse<Map<String, String>>> upload(@RequestParam("file") MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY)
                    .body(new ApiResponse<>(null, "file_empty"));
        }
        Path uploadDir = Paths.get("uploads");
        Files.createDirectories(uploadDir);
        String filename = LocalDateTime.now().toString().replace(":", "-") + "_" + file.getOriginalFilename();
        Path target = uploadDir.resolve(filename);
        Files.write(target, file.getBytes());
        String url = "/uploads/" + filename;
        return ResponseEntity.ok(new ApiResponse<>(Map.of("url", url), "uploaded"));
    }
}

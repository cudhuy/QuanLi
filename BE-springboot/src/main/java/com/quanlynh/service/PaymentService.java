package com.quanlynh.service;

import com.quanlynh.entity.Order;
import com.quanlynh.entity.Payment;
import com.quanlynh.repository.OrderRepository;
import com.quanlynh.repository.PaymentRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Service
public class PaymentService {
    private final PaymentRepository paymentRepository;
    private final OrderRepository orderRepository;

    public PaymentService(PaymentRepository paymentRepository, OrderRepository orderRepository) {
        this.paymentRepository = paymentRepository;
        this.orderRepository = orderRepository;
    }

    public Map<String, Object> createInternalPayment(Map<String, Object> request) {
        Payment payment = buildPayment(request, "cash");
        paymentRepository.save(payment);
        Map<String, Object> response = new HashMap<>();
        response.put("review_url", "https://payment.local/review/" + UUID.randomUUID());
        response.put("qr_code_base64", "data:image/png;base64,QUJDRGVmZw==");
        response.put("status", payment.getStatus());
        response.put("data", payment);
        return response;
    }

    public Map<String, Object> createVnPayPayment(Map<String, Object> request) {
        Payment payment = buildPayment(request, "VNPay");
        paymentRepository.save(payment);
        Map<String, Object> response = new HashMap<>();
        response.put("payment_url", "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html");
        response.put("url", "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html");
        response.put("status", payment.getStatus());
        response.put("data", payment);
        return response;
    }

    public Map<String, Object> handleVnPayCallback(Map<String, String> params) {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "callback_received");
        response.put("params", params);
        return response;
    }

    private Payment buildPayment(Map<String, Object> request, String defaultMethod) {
        Long orderId = request.get("order_id") instanceof Number ? ((Number) request.get("order_id")).longValue() : null;
        Order order = Optional.ofNullable(orderId).flatMap(orderRepository::findById).orElseThrow();
        BigDecimal amount = order.getTotalPrice();
        if (request.get("amount") instanceof Number num) {
            amount = BigDecimal.valueOf(num.doubleValue());
        }
        Payment payment = new Payment();
        payment.setOrder(order);
        payment.setAmount(amount);
        payment.setMethod(String.valueOf(request.getOrDefault("method", defaultMethod)));
        payment.setStatus("completed");
        payment.setCreatedAt(LocalDateTime.now());
        payment.setUpdatedAt(LocalDateTime.now());
        order.setStatus("completed");
        orderRepository.save(order);
        return payment;
    }
}

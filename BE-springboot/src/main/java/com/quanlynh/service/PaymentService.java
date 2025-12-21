package com.quanlynh.service;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class PaymentService {
    public Map<String, Object> createInternalPayment(Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        response.put("review_url", "https://payment.local/review/" + UUID.randomUUID());
        response.put("qr_code_base64", "data:image/png;base64,QUJDRGVmZw==");
        response.put("status", "created");
        return response;
    }

    public Map<String, Object> createVnPayPayment(Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        response.put("payment_url", "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html");
        response.put("status", "created");
        return response;
    }

    public Map<String, Object> handleVnPayCallback(Map<String, String> params) {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "callback_received");
        response.put("params", params);
        return response;
    }
}

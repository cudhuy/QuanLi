package com.quanlynh.service;

import com.quanlynh.dto.RatingRequest;
import com.quanlynh.entity.Order;
import com.quanlynh.entity.Rating;
import com.quanlynh.repository.OrderRepository;
import com.quanlynh.repository.RatingRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class RatingService {
    private final RatingRepository ratingRepository;
    private final OrderRepository orderRepository;

    public RatingService(RatingRepository ratingRepository, OrderRepository orderRepository) {
        this.ratingRepository = ratingRepository;
        this.orderRepository = orderRepository;
    }

    public Rating create(RatingRequest request) {
        Order order = orderRepository.findById(request.getOrderId()).orElseThrow();
        Rating rating = new Rating();
        rating.setOrder(order);
        rating.setRating(request.getRating());
        rating.setComment(request.getComment());
        rating.setCreatedAt(LocalDateTime.now());
        return ratingRepository.save(rating);
    }

    public Rating getForm(Long orderId) {
        Order order = orderRepository.findById(orderId).orElseThrow();
        Rating rating = new Rating();
        rating.setOrder(order);
        rating.setRating(0);
        return rating;
    }
}

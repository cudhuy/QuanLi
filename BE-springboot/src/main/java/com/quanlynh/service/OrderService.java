package com.quanlynh.service;

import com.quanlynh.dto.OrderItemRequest;
import com.quanlynh.dto.OrderRequest;
import com.quanlynh.entity.*;
import com.quanlynh.repository.*;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final MenuItemRepository menuItemRepository;
    private final UserRepository userRepository;
    private final DiningTableRepository diningTableRepository;

    public OrderService(OrderRepository orderRepository,
                        OrderItemRepository orderItemRepository,
                        MenuItemRepository menuItemRepository,
                        UserRepository userRepository,
                        DiningTableRepository diningTableRepository) {
        this.orderRepository = orderRepository;
        this.orderItemRepository = orderItemRepository;
        this.menuItemRepository = menuItemRepository;
        this.userRepository = userRepository;
        this.diningTableRepository = diningTableRepository;
    }

    public Order create(OrderRequest request) {
        Order order = new Order();
        if (request.getUserId() != null) {
            userRepository.findById(request.getUserId()).ifPresent(order::setUser);
        }
        if (request.getTableId() != null) {
            diningTableRepository.findById(request.getTableId()).ifPresent(order::setTable);
        }
        order.setStatus("pending");
        order.setPaymentStatus("unpaid");
        order.setPaymentMethod(request.getPaymentMethod());
        order.setNote(request.getNote());
        order.setCreatedAt(LocalDateTime.now());

        BigDecimal total = BigDecimal.ZERO;
        for (OrderItemRequest itemRequest : request.getItems()) {
            MenuItem menuItem = menuItemRepository.findById(itemRequest.getMenuItemId()).orElseThrow();
            OrderItem item = new OrderItem();
            item.setOrder(order);
            item.setMenuItem(menuItem);
            item.setQuantity(itemRequest.getQuantity());
            item.setPrice(menuItem.getPrice());
            order.getItems().add(item);
            total = total.add(menuItem.getPrice().multiply(BigDecimal.valueOf(itemRequest.getQuantity())));
            menuItem.setSoldCount(menuItem.getSoldCount() + itemRequest.getQuantity());
        }
        order.setTotalAmount(total);
        Order saved = orderRepository.save(order);
        orderItemRepository.saveAll(saved.getItems());
        return saved;
    }

    public List<OrderItem> listItems(Long orderId) {
        return orderItemRepository.findByOrderId(orderId);
    }

    public Order updateStatus(Long id, String status) {
        Order order = orderRepository.findById(id).orElseThrow();
        order.setStatus(status);
        return orderRepository.save(order);
    }
}

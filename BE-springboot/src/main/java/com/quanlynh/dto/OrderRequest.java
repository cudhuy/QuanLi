package com.quanlynh.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.List;

@Data
public class OrderRequest {
    private Long userId;
    private Long tableId;
    private String note;
    private String paymentMethod;

    @Valid
    @NotEmpty
    private List<OrderItemRequest> items;
}

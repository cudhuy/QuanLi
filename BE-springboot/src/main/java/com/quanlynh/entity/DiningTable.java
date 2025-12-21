package com.quanlynh.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "tables")
@Getter
@Setter
public class DiningTable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "table_number", nullable = false, unique = true)
    private String tableNumber;

    @Column(name = "qr_code")
    private String qrCode;

    @Column(name = "status")
    private String status;
}

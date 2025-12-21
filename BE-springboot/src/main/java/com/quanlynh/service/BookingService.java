package com.quanlynh.service;

import com.quanlynh.dto.BookingRequest;
import com.quanlynh.entity.Booking;
import com.quanlynh.repository.BookingRepository;
import com.quanlynh.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookingService {
    private final BookingRepository bookingRepository;

    public BookingService(BookingRepository bookingRepository) {
        this.bookingRepository = bookingRepository;
    }

    public Booking create(BookingRequest request) {
        Booking booking = new Booking();
        booking.setCustomerName(request.getCustomerName());
        booking.setEmail(request.getEmail());
        booking.setPhone(request.getPhone());
        booking.setBookingDate(request.getBookingDate());
        booking.setBookingTime(request.getBookingTime());
        booking.setGuests(request.getGuests());
        booking.setNote(request.getNote());
        booking.setStatus("pending");
        return bookingRepository.save(booking);
    }

    public List<Booking> list() {
        return bookingRepository.findAll();
    }

    public Booking updateStatus(Long id, String status) {
        Booking booking = bookingRepository.findById(id).orElseThrow();
        booking.setStatus(status);
        return bookingRepository.save(booking);
    }
}

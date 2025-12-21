package com.quanlynh.service;

import com.quanlynh.dto.TableRequest;
import com.quanlynh.entity.DiningTable;
import com.quanlynh.repository.DiningTableRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TableService {
    private final DiningTableRepository diningTableRepository;

    public TableService(DiningTableRepository diningTableRepository) {
        this.diningTableRepository = diningTableRepository;
    }

    public List<DiningTable> list() {
        return diningTableRepository.findAll();
    }

    public DiningTable get(Long id) {
        return diningTableRepository.findById(id).orElseThrow();
    }

    public DiningTable create(TableRequest request) {
        DiningTable table = new DiningTable();
        apply(table, request);
        return diningTableRepository.save(table);
    }

    public DiningTable update(Long id, TableRequest request) {
        DiningTable table = get(id);
        apply(table, request);
        return diningTableRepository.save(table);
    }

    private void apply(DiningTable table, TableRequest request) {
        table.setTableNumber(request.getTableNumber());
        table.setQrCode(request.getQrCode());
    }
}

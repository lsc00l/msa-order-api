package com.ecommerce.order.service;

import com.ecommerce.order.event.OrderEventPublisher;
import com.ecommerce.order.model.Order;
import com.ecommerce.order.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.MeterRegistry;

import javax.annotation.PostConstruct;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final MeterRegistry meterRegistry;
    private Counter orderCounter;
    @Autowired
    private OrderEventPublisher orderEventPublisher;

    public OrderService(OrderRepository orderRepository, MeterRegistry meterRegistry) {
        this.orderRepository = orderRepository;
        this.meterRegistry = meterRegistry;
    }

    @PostConstruct
    private void initMetrics() {
        this.orderCounter = Counter.builder("order.created.count")
                .description("Number of created orders")
                .register(meterRegistry);
    }

    public void createOrder(Order order) {
        orderRepository.save(order);
        orderCounter.increment();
        orderEventPublisher.publishOrderCreated(order.getId());

    }

    public Order getOrderById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }
}

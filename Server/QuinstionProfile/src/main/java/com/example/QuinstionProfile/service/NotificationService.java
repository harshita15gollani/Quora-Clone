package com.example.QuinstionProfile.service;

import com.example.QuinstionProfile.dto.NotificationDto;

import java.util.List;


public interface NotificationService {
    public NotificationDto addNotification(NotificationDto notificationDto);
    public List<NotificationDto> viewNotification(String accountId);
}

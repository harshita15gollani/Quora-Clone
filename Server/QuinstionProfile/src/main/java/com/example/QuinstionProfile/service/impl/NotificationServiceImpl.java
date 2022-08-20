package com.example.QuinstionProfile.service.impl;

import com.example.QuinstionProfile.dto.NotificationDto;
import com.example.QuinstionProfile.entity.Notification;
import com.example.QuinstionProfile.repository.NotificationRepository;
import com.example.QuinstionProfile.service.NotificationService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.BeanNameAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    NotificationRepository notificationRepository;

    @Override
    public NotificationDto addNotification(NotificationDto notificationDto) {
        Notification notification = new Notification();
        BeanUtils.copyProperties(notificationDto,notification);
        notificationRepository.save(notification);
        return notificationDto;
    }

    @Override
    public List<NotificationDto> viewNotification(String accountId) {
        List<Notification> notification = notificationRepository.findByAccountId(accountId);
        if (!notification.isEmpty()) {
            List<NotificationDto> returnNotification = new ArrayList<>();
            for (Notification n : notification) {
                NotificationDto notificationDto = new NotificationDto();
                BeanUtils.copyProperties(n, notificationDto);
                returnNotification.add(notificationDto);
            }

//            returnNotification.sort();
            Collections.reverse(returnNotification);
            System.out.println(returnNotification);
            return returnNotification;
        }
        else {
            System.out.println("notification is empty");
            return null;
        }
    }
}

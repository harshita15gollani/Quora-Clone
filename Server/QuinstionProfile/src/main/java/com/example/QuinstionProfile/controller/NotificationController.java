package com.example.QuinstionProfile.controller;

import com.example.QuinstionProfile.dto.NotificationDto;
import com.example.QuinstionProfile.service.NotificationService;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@CrossOrigin("*")
@RestController
@RequestMapping("/notification")
public class NotificationController {

    @Autowired
    NotificationService notificationService;

    @PostMapping(value = "/add")
    public NotificationDto addNotification(@RequestBody NotificationDto notificationDto){
        return notificationService.addNotification(notificationDto);
    }

    @GetMapping(value = "/view/{accountId}")
    public List<NotificationDto> viewNotification(@PathVariable("accountId") String accountId){
        return notificationService.viewNotification(accountId);
    }
}

package com.example.QuinstionProfile.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NotificationDto {
    private String accountId;
    private String recipientUserName;
    private String recipientAccountId;
    private String description;
    private String recipientProfileImage;
}

package com.example.QuinstionProfile.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Getter
@Setter
@ToString
@Document
public class Notification {
    @Id
    String id;
    private String accountId;
    private String recipientUserName;
    private String recipientAccountId;
    private String description;
    private String recipientProfileImage;
}

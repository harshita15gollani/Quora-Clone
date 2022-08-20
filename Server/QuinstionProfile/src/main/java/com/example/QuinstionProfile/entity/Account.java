package com.example.QuinstionProfile.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Setter
@Getter
@ToString
@Document(collection = "UserAccount")
//enum gender{
//    MALE, FEMALE, OTHERS;
//}
//
//enum accountType{
//    PUBLIC, PRIVATE, CORPORATE;
//}

public class Account {
    @Id
    String id;
    // todo : remove accountId from the entity and should not be in database
//    String accountId; // unwanted
    String userName;
    String email;
    String description;
    String phoneNumber;
    String password;
    String gender;
    int score;
    String scoreBatch;
    String accountType;
    String profileImage;

}
